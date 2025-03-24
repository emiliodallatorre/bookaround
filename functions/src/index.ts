import * as admin from "firebase-admin";
import * as chat from "./chat";
import * as isbndb from "./isbndb";
import * as users from "./users";

admin.initializeApp();

// Funzioni di "./users".
export const createUserInDatabase = users.createUserInDatabase;
export const deleteUserInDatabase = users.deleteUserInDatabase;
export const deleteUser = users.deleteUser;

// Funzioni di "./chat".
export const getChatId = chat.getChatId;
export const updateChatModel = chat.updateChatModel;

// Funzioni di "./isbndb".
export const createBookSell = isbndb.createBookSell;
export const findBook = isbndb.findBook;