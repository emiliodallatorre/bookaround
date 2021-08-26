import * as admin from "firebase-admin";

const fetch = require("node-fetch");

const baseUrl: string = "https://api2.isbndb.com/";
const key: string = "45271_d1fdc77384e6af8828ce3a8530f70dcd";
const headers = { "Content-Type": 'Application/Json', "Authorization": key };

export async function searchTextInIsbndb(query: string): Promise<Array<any>> {
    const apiUrl: string = baseUrl + "books/" + encodeURIComponent(query);
    const response: Response = await fetch(apiUrl, { headers: headers });

    const result: Array<any> = Array<any>();
    if (response.status !== 200) {
        console.log("La query \"", query, "\" non ha risultati su isbndb.")
        return result;
    } else {
        const rawResult = await response.json();
        return rawResult["books"];
    }
}

export async function searchTextInFirebase(query: string): Promise<Array<any>> {
    let result: Array<any> = Array<any>();
    const allIsbns: Array<admin.firestore.DocumentSnapshot> = (await admin.firestore().collection("isbns").get()).docs;

    console.log("Cerco fra", allIsbns.length, "ISBN locali.");

    const rawResult: Array<any> = Array<any>();
    const queryTerms: string[] = getTerms([query]);
    for (const rawIsbn of allIsbns) {
        const data: admin.firestore.DocumentData = rawIsbn.data() as admin.firestore.DocumentData;

        const title: string = data["title"];
        const authors: string = (data["authors"] as string[]).toString();
        const isbn: string = data["isbn"];

        const terms: string[] = [];
        terms.push(title);
        terms.push(authors);
        terms.push(isbn);

        const isbnTerms: string[] = getTerms(terms);

        if (compareTerms(queryTerms, isbnTerms) > 0) rawResult.push([compareTerms(queryTerms, isbnTerms), rawIsbn.data()]);
    }
    rawResult.sort((b, a) => a[0] - b[0]);
    result = result.concat(rawResult.slice(0, 6).map(x => x[1]));

    return result;
}

export async function searchIsbnInIsbndb(isbn: string): Promise<any> {
    const apiUrl: string = baseUrl + "book/" + isbn;
    const response: Response = await fetch(apiUrl, { headers: headers });

    if (response.status !== 200) {
        console.log("Il libro", isbn, "non è su isbndb.")
        return null;
    }
    else {
        const jsonData = (await response.json());
        if (jsonData["errorMessage"] !== undefined) return null;

        console.log("Il libro", isbn, "è su isbndb.");
        const result = jsonData["book"];
        return result;
    }
}

export async function searchIsbnInFirebase(isbn: string): Promise<any> {
    const query = await admin.firestore().collection("isbns").where(isbn.length === 13 ? "isbn13" : "isbn", "==", isbn).get();

    if (query.docs.length === 0) {
        console.log("Il libro", isbn, "non è nel nostro database.");
        return null;
    } else {
        console.log("Il libro", isbn, "è nel nostro database.");
        return query.docs[0].data();
    }
}

function cleanStrin(original: string): string {
    return original.replace(/\W/g, '').toLowerCase()
}

function getTerms(original: string[]): string[] {
    const result: string[] = [];
    const words: string[] = [];

    for (const part of original) if (part !== null) for (const word of part.split(" ")) words.push(word);

    for (const word of words) {
        const cleanWord: string = cleanStrin(word);
        if (cleanWord !== "") result.push(cleanWord);
    }

    return result;
}

function compareTerms(query: string[], terms: string[]): number {
    const filteredArray: string[] = terms.filter(value => query.includes(value));

    /* console.log("Comparo", JSON.stringify(query), "e", JSON.stringify(terms), ".");
    console.log("Punteggio: ", (filteredArray.length / terms.length), "."); */

    return (filteredArray.length / terms.length);
}