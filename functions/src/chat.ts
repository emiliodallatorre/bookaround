import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { getUser, UserModel } from "./users";


/// Restituisce la corretta [chatId] all'utente che la chiede.
export const getChatId = functions.https.onCall(async (data, context) => {
    const requesterUid: string = data["uid"] as string
    const chatParticipants: string[] = data["participants"] as string[]

    if (requesterUid !== undefined) {
        if (chatParticipants.includes(requesterUid)) {

            if (!(await admin.firestore().collection("users").doc(requesterUid).get()).exists) {
                console.log("Un utente ha tentato di effettuare una ricerca di chat senza login o in uno scope esterno al suo!")
                return []
            }
        } else {
            return []
        }
    } else {
        return []
    }


    console.log("Cerco la chat fra", chatParticipants, ".")

    const possibleChats: admin.firestore.QueryDocumentSnapshot[] = (await admin.firestore().collection("chats").where("participants", "array-contains-any", chatParticipants).get()).docs

    console.log("Ho trovato", possibleChats.length, "possibili chat.")

    let result: string = ""
    for (const chat of possibleChats) {
        const _chatParticipants: string[] = chat.data()["participants"] as string[]

        // Controlliamo che contenga tutti gli utenti che vogliamo.
        let _stop: boolean = false
        for (const participant of chatParticipants) {
            if (!_chatParticipants.includes(participant)) {
                console.log("La chat", chat.data()["id"], "non ha tutti i partecipanti voluti.")
                _stop = true
            }
        }
        if (_stop) continue

        // Controlliamo che non contenga più degli utenti che vogliamo.
        else {
            for (const participant of chatParticipants) {
                const index = _chatParticipants.indexOf(participant)

                if (index > -1) {
                    _chatParticipants.splice(index, 1)
                }
            }

            /// Rimossi tutti i partecipanti, la lista è vuota.
            if (_chatParticipants.length === 0) {
                console.log("L'array è vuoto: restituisco il dato.")
                result = chat.data()["id"]
                break
            } else {
                console.log("La chat", chat.data()["id"], "ha più dei partecipanti voluti.")
            }
        }
    }

    // Qui creiamo un nuovo modulo per la chat nel caso non ne esista uno.
    if (result === "") result = await createChat(chatParticipants)

    //@ts-ignore
    return result
});


/// Aggiorna il modello della chat.
export const updateChatModel = functions.firestore.document('/chats/{chatId}/messages/{messageId}').onCreate(async (snapshot, context) => {
    const parentChat: admin.firestore.DocumentReference = snapshot.ref.parent.parent as admin.firestore.DocumentReference

    const message: admin.firestore.DocumentData = (await snapshot.ref.parent.orderBy("sentDateTime", "desc").get()).docs[0].data()

    // Aggiorniamo la chat.
    await parentChat.update({ "lastMessageDateTime": getCurrentDateAsString(), lastMessage: message })
    console.log("Aggiorno l'ultimo messaggio inviato.")

    // Inviamo le dovute notifiche.
    await sendMessageNotification(snapshot, context.params.chatId)
});


/// Crea una chat fra due utenti.
async function createChat(participants: string[]): Promise<string> {
    const chatId: string = randomString(20)

    await admin.firestore().collection("chats").doc(chatId).set(
        {
            "id": chatId,
            "creationDateTime": getCurrentDateAsString(),
            "participants": participants,
        }
    )

    return chatId
}


// Invia una notifica per un messaggio.
async function sendMessageNotification(message: functions.firestore.QueryDocumentSnapshot, chatId: string) {
    const recipients: string[] = ((await (message.ref.parent.parent as admin.firestore.DocumentReference).get()).data() as admin.firestore.DocumentData)["participants"]

    const senderUser: UserModel = await getUser(message.data()["senderUid"])

    const payload: admin.messaging.MessagingPayload = {
        notification: {
            title: senderUser["name"] + " " + senderUser["surname"],
            body: message.data()["body"],
            sound: "default",
        },
        data: {
            "type": "CHAT",
            "notificationData": chatId,
        },
    }

    for (const recipient of recipients)
        if (recipient !== senderUser.uid) {
            const recipientUser: UserModel = await getUser(recipient);

            if (recipientUser.blockedUids !== undefined && recipientUser.blockedUids !== null) if (recipientUser.blockedUids.includes(senderUser.uid)) continue;

            await admin.messaging().sendToTopic(recipient, payload)
        }

    console.log("Ho inviato le dovute notifiche.")
}


/// Crea una stringa casualmente generata.
export function randomString(length: number): string {
    const chars: string = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    let result: string = '';
    for (let i = length; i > 0; --i) result += chars[Math.round(Math.random() * (chars.length - 1))];
    return result;
}

export function getCurrentDateAsString(): string {
    const currentDateTime: Date = new Date();
    // currentDateTime.setHours(currentDateTime.getHours() + 2);
    return currentDateTime.toISOString();
}