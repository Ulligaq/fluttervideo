/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */


const { initializeApp, getAnalytics } = require('firebase/app');

const firebaseConfig = {
    
  };

const app = initializeApp(firebaseConfig);

const functions = require('firebase-functions');
const { onRequest } = functions.https;
const admin = require("firebase-admin");
admin.initializeApp(firebaseConfig);
const db = admin.firestore();


const logger = require("firebase-functions/logger");


const labRef = db.collection('movietime').doc('D0M0VT69ucDlJIX8xn6D');

exports.readLab = onRequest({timeoutSeconds: 15, cors: true, maxInstances: 10},
    (request, response) => {
        labRef.get().then((doc) => {
            if (doc.exists){
                response.send(doc.data());
            } else {
                logger.info("No such Document", { structuredData: true });
            }
        })
    });
// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
