import { v4 as uuidv4 } from "uuid";
import admin from "firebase-admin";

const getID = () => {
  return uuidv4();
};

const getTimestamp = () => {
  return admin.database.ServerValue.TIMESTAMP;
};

export { getID, getTimestamp };
