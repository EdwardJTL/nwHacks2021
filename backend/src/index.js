import express from "express";
import admin from "firebase-admin";
import cors from "cors";
import { addFriend, editProfile } from "./functions/user.js";

admin.initializeApp({
  credential: admin.credential.applicationDefault(),
  databaseURL: "https://nwhacks-78e9f-default-rtdb.firebaseio.com/",
});

const db = admin.database();

const app = express();
app.use(express.json());
app.use(cors());

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept"
  );
  next();
});

app.post("/friend", (req, res) => {
  const { userID, friendID } = req.body;
  addFriend(db, userID, friendID);
  res.send("ayy lmao");
});

app.post("/profile", (req, res) => {
  const { userID, interests, biography } = req.body;
  editProfile(db, userID, interests, biography);
  res.send("ahahahaha");
});

app.post("/skill", (req, res) => {
  const { userID, skillname, picture } = req.body;
});

app.listen(8080);
