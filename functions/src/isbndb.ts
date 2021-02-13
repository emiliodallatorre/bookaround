import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as search from "./search";

import { randomString } from "./chat"

export const createBookSell = functions.https.onCall(async (data, context) => {
    const isbn: string = data["isbn"] as string
    const userUid: string = data["uid"] as string

    let book = await search.searchIsbnInIsbndb(isbn);

    if (book === null) {
        book = await search.searchIsbnInFirebase(isbn);

        if (book === null) return null;
    }

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


export const findBook = functions.https.onCall(async (data, context) => {
    const query: string = data["query"] as string;
    // const isIsbn: boolean = data["isIsbn"] as boolean;
    const userUid: string = data["uid"] as string;

    console.log("Cerco il libro \"", query, "\" per conto di", userUid, ".");

    let result: Array<any> = Array<any>();

    const resultsFromIsbndb: Array<any> = await search.searchTextInIsbndb(query);
    const resultsFromFirebase: Array<any> = await search.searchTextInFirebase(query);

    console.log("Ho trovato", resultsFromFirebase.length, "risultati in Firebase e", resultsFromIsbndb.length, "risultati in ISBNdb.");

    result = result.concat(resultsFromFirebase, resultsFromIsbndb);
    return result;
})