import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

export const notifySearchers = functions.firestore.document('/books/{bookId}').onCreate(async (snapshot, context) => {
    // TODO: Implementare.
});