import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const createUserInDatabase = functions.auth.user().onCreate(async (user) => {
    await admin.firestore().collection("users").doc(user.uid).set({
        uid: user.uid,
        phoneNumber: user.phoneNumber,
    });

    console.log("Creato il profilo utente per ", user.uid, ".");
});

export const deleteUserInDatabase = functions.auth.user().onDelete(async (user) => {
    await admin.firestore().collection("users").doc(user.uid).delete();

    console.log("Eliminato il profilo utente per ", user.uid, ".");
});

export const deleteUser = functions.https.onCall(async (data, context) => {
    const uid: string = data["uid"];

    // @ts-ignore
    if (context.auth.uid !== uid) {
        console.log("Qualcuno gioca a cancellare gli account degli altri...");
        return;
    }

    const reference: admin.firestore.DocumentReference = admin.firestore().collection("users").doc(uid);
    const userData = (await reference.get()).data()

    if (userData !== undefined) {
        await reference.delete();
        await admin.auth().deleteUser(uid);

        console.log("Ho eliminato un'account perché incompleto.");
    } else console.log("Non ho eliminato un account perché era completo.");
});

export async function getUser(uid: string): Promise<admin.firestore.DocumentData> {
    return (await admin.firestore().collection("users").doc(uid).get()).data() as admin.firestore.DocumentData
}