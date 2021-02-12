import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

import { randomString } from "./chat"

const key: string = "45271_d1fdc77384e6af8828ce3a8530f70dcd"
const fetch = require("node-fetch")

export const createBookSell = functions.https.onCall(async (data, context) => {
    const isbn: string = data["isbn"] as string
    const userUid: string = data["uid"] as string

    const apiUrl: string = "https://api2.isbndb.com/book/" + isbn

    const headers = {
        "Content-Type": 'Application/Json',
        "Authorization": key,
    }

    let book
    const response: Response = await fetch(apiUrl, { headers: headers });
    if (response.status !== 200) {
        console.log("Il libro", isbn, "non è nel database. Controllo nel database personale.");

        const query = await admin.firestore().collection("isbns").where("isbn", "==", isbn).get()
        if (query.docs.length == 0) {
            console.log("Il libro non è neanche nel nostro database.");
            return;
        }
        else {
            console.log("Il libro c'è nel nostro database.");
            book = query.docs[0].data();
        }
    } else book = (await response.json())["book"];

    const bookId: string = randomString(20)
    const bookModel = {
        id: bookId,
        isbn: book["isbn"],
        title: book["title"],
        authors: book["authors"],
        coverUrl: book["image"],
        type: "SELLING",
        userUid: userUid,
        addedDateTime: new Date().toISOString(),
        highlighting: true,
        pen: true,
        pencil: true,
        note: "",
    }

    await admin.firestore().collection("books").doc(bookId).set(bookModel)

    console.log("Creato il libro", isbn, "in vendita per conto di", userUid, ".")

    return JSON.stringify(bookModel)
})