import express from "express";
import admin from "firebase-admin";
import cors from "cors";
import { getFriends, addFriend } from "./functions/friend.js";
import {
  addPost,
  addClap,
  addComment,
  getPosts,
  getNewsfeed,
  getComments,
} from "./functions/post.js";
import { startSkill, finishSkill, getSkills } from "./functions/skill.js";
import { editProfile, getProfile } from "./functions/user.js";

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

app.get("/friend/:userID", async (req, res) => {
  const { userID } = req.params;
  const friends = await getFriends(db, userID);
  res.send({
    friends: friends,
  });
});

app.get("/newsfeed/:userID", async (req, res) => {
  const { userID } = req.params;
  const posts = await getNewsfeed(db, userID);
  res.send({
    posts: posts,
  });
});

app.get("/comments/:posterID/:postID", async (req, res) => {
  const { posterID, postID } = req.params;
  const comments = await getComments(db, posterID, postID);
  res.send({
    comments: comments,
  });
});

app.get("/skills/:userID", async (req, res) => {
  const { userID } = req.params;
  const skills = await getSkills(db, userID);
  res.send({
    skills: skills,
  });
});

app.get("/profile/:userID", async (req, res) => {
  const { userID } = req.params;
  const profile = await getProfile(db, userID);
  res.send(profile);
});

app.get("/posts/:userID", async (req, res) => {
  const { userID } = req.params;
  const posts = await getPosts(db, userID);
  res.send({
    posts: posts,
  });
});

app.post("/friend", async (req, res) => {
  const { userID, friendID } = req.body;
  await addFriend(db, userID, friendID);
  res.send({
    success: true,
  });
});

app.post("/post", async (req, res) => {
  const { userID, picture, content, title, tags } = req.body;
  const [id, timestamp] = await addPost(
    db,
    userID,
    picture,
    content,
    title,
    tags
  );
  console.log(timestamp);
  res.send({
    postID: id,
    postedAt: timestamp,
  });
});

app.post("/clap", async (req, res) => {
  const { posterID, postID } = req.body;
  await addClap(db, posterID, postID);
  res.send({
    success: true,
  });
});

app.post("/comment", async (req, res) => {
  const { commenterID, comment, posterID, postID } = req.body;
  const [id, timestamp] = await addComment(
    db,
    commenterID,
    comment,
    posterID,
    postID
  );
  res.send({
    commentID: id,
    postedAt: timestamp,
  });
});

app.post("/skill/start", async (req, res) => {
  const { userID, skill } = req.body;
  const timestamp = await startSkill(db, userID, skill);
  res.send({
    startedAt: timestamp,
  });
});

app.post("/skill/finish", async (req, res) => {
  const { userID, skill, picture, title, shared, content } = req.body;
  const timestamp = await finishSkill(
    db,
    userID,
    skill,
    picture,
    title,
    content,
    true
  );
  res.send({
    finishedAt: timestamp,
  });
});

app.post("/profile", async (req, res) => {
  const { userID, name, biography, interests } = req.body;
  await editProfile(db, userID, name, biography, interests);
  res.send({
    success: true,
  });
});

app.listen(8080);
