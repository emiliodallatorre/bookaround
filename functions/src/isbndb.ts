import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as search from "./search";

import { getCurrentDateAsString, randomString } from "./chat"

export const createBookSell = functions.https.onCall(async (data, context) => {
    const isbn: string = data["isbn"] as string
    const userUid: string = data["uid"] as string

    let book = await search.searchIsbnInIsbndb(isbn);

    if (book === null) {
        book = await search.searchIsbnInFirebase(isbn);

        if (book === null) return null;
    }

    const bookId: string = randomString(20)
    const bookModel: BookModel = {
        id: bookId,
        isbn13: book["isbn13"],
        isbn: book["isbn"],
        title: book["title"],
        authors: book["authors"],
        coverUrl: book["image"],
        type: "SELLING",
        userUid: userUid,
        addedDateTime: getCurrentDateAsString(),
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

    console.log("Ho trovato", resultsFromFirebase.length, "risultati in Firebase e", resultsFromIsbndb.length, "risultati in ISBNdb. Restituisco.");

    result = result.concat(resultsFromFirebase, resultsFromIsbndb);
    return JSON.stringify(result);
})

interface BookModel {
    id: string,
    isbn13: string,
    isbn: string,
    title: string,
    authors: string,
    coverUrl: string,
    type: string,
    userUid: string,
    addedDateTime: string,
    highlighting: boolean,
    pen: boolean,
    pencil: boolean,
    note: string,
}