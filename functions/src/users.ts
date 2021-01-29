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

// Cambia, su richiesta, il tipo di utente.
export const setUserType = functions.https.onCall(async (data, context) => {
    const reference: admin.firestore.DocumentReference = admin.firestore().collection("users").doc(data["uid"])

    const newUserType: string = data["userType"].split(".")[1]

    if ((await reference.get()).get("userType") === null)
        await reference.update({ userType: newUserType })

    console.log("Ho cambiato il tipo dell'utente", data["uid"], "a", newUserType, ".")
});

export const deleteUser = functions.https.onCall(async (data, context) => {
    const uid: string = data["uid"];

    // @ts-ignore
    if (context.auth.uid !== uid) {
        console.log("Qualcuno sta tentando di giocare con gli account degli altri.");
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