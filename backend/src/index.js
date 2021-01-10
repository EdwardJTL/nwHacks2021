import express from "express";
import admin from "firebase-admin";
import cors from "cors";
import {
  addFriend,
  editProfile,
  addSkill,
  finishSkill,
  addPost,
  clap,
  getNewsfeed,
  getComments,
} from "./functions/user.js";

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
  res.send("You've added a friend!");
});

app.post("/profile", (req, res) => {
  const { userID, interests, biography } = req.body;
  editProfile(db, userID, interests, biography);
  res.send("Profile edited.");
});

app.post("/skill", async (req, res) => {
  const { userID, skillname } = req.body;
  const postID = await addSkill(db, userID, skillname);
  res.send({
    postID: postID,
  });
});

app.patch("/skill", async (req, res) => {
  const { userID, skillname, picture } = req.body;
  finishSkill(db, userID, skillname, picture);
});

app.post("/post", async (req, res) => {
  const { userID, title, tags, skill, post } = req.body;
  const postID = await addPost(db, userID, title, tags, skill, post);
  res.send({
    postID: postID,
  });
});

app.post("/clap", (req, res) => {
  const { userID, clapperID, postID } = req.body;
  clap(db, userID, clapperID, postID);
  res.send("Clap received!");
});

app.get("/newsfeed/user/:userID", async (req, res) => {
  const { userID } = req.params;
  const newsfeed = await getNewsfeed(db, userID);
  res.send(newsfeed);
});

app.post("/comment", (req, res) => {
  const { userID, comment, posterID, postID } = req.body;
  addComment(db, userID, comment, posterID, postID);
});

app.get("/comment/:postID/:posterID", async (req, res) => {
  const { postID, posterID } = req.params;
  const comments = await getComments(db, posterID, postID);
  res.send(comments);
});

app.listen(8080);
