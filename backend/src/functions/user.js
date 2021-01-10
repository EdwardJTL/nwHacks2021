import { v4 as uuidv4 } from "uuid";
import admin from "firebase-admin";

const addFriend = (db, userID, friendID) => {
  const ref = db.ref(`users/${userID}/friends`);
  ref.push(friendID);
};

const editProfile = (db, userID, interests, biography) => {
  const ref = db.ref(`users/${userID}`);
  ref.update({
    interests: interests,
    biography: biography,
  });
};

const addSkill = async (db, userID, skill) => {
  const ref = db.ref(`users/${userID}/skills`);
  const [id, timestamp] = await addPost(
    db,
    userID,
    `${userID} has started working on ${skillname}.`,
    [],
    skill,
    "",
    null
  );
  await ref.push({
    skill: skill,
    started: timestamp,
  });
  return id;
};

const finishSkill = async (db, userID, skill, picture) => {
  const ref = db.ref(`users/${userID}/skills`);
  const [id, timestamp] = await addPost(
    db,
    userID,
    `${userID} has finished working on ${skillname}.`,
    [],
    skill,
    "",
    picture
  );
  ref
    .orderByChild("skill")
    .equalTo(skill)
    .once("value")
    .then((snapshot) => {
      console.log(snapshot);
      return id;
    });
};

const addPost = async (db, userID, title, tags, skill, post, picture) => {
  const ref = db.ref(`users/${userID}/posts`);
  const id = uuidv4();
  const timestamp = admin.database.ServerValue.TIMESTAMP;
  await ref.push({
    postID: id,
    title: title,
    tags: tags,
    skill: skill,
    post: post,
    created: timestamp,
  });
  return [id, timestamp];
};

const clap = (db, userID, clapperID, postID) => {
  const ref = db.ref(`users/${userID}/posts/${postID}`);
  ref.push(clapperID);
};

const getNewsfeed = async (db, userID) => {
  const ref = db.ref(`users/${userID}/friends`);
  const friends = await getFriends(db, userID);
  let posts = [];
  for (let i = 0; i < friends.length; ++i) {
    const newPosts = await getPosts(db, friends[i]);
    console.log(newPosts);
    posts = posts.concat(newPosts);
  }

  return posts;
};

const getFriends = async (db, userID) => {
  const ref = db.ref(`users/${userID}/friends`);
  const friends = await ref.once("value").then(async (snapshot) => {
    const allFriends = [];
    await snapshot.forEach((friend) => {
      allFriends.push(friend.val());
    });
    return allFriends;
  });
  return friends;
};

const getPosts = async (db, userID) => {
  const ref = db.ref(`users/${userID}/posts`);
  return await ref.once("value").then(async (snapshot) => {
    const posts = [];
    await snapshot.forEach((post) => {
      console.log(post.toJSON());
      posts.push(post.toJSON());
    });
    return posts;
  });
};

const addComment = async (db, userID, comment, posterID, postID) => {
  const ref = db.ref(`users/${posterID}/posts`);
  await ref.once("value").then(async (snapshot) => {
    await snapshot.forEach((post) => {
      if (post.child("postID") === postID) {
        const newRef = db.ref(`users/${posterID}/posts/${post.key}`);
        newRef.push({
          userID: userID,
          comment: comment,
        });
      }
    });
  });
};

const getComments = async (db, posterID, postID) => {
  const ref = db.ref(`users/${posterID}/posts`);
  return await ref.once("value").then(async (snapshot) => {
    await snapshot.forEach((post) => {
      if (post.child("postID") === postID) {
        const newRef = db.ref(`users/${posterID}/posts/${post.key}`);
        newRef.once("value").then(async (snapshot) => {
          const comments = [];
          snapshot.forEach((comment) => {});
        });
      }
    });
  });
};

export {
  addFriend,
  editProfile,
  addSkill,
  finishSkill,
  addPost,
  clap,
  getNewsfeed,
  addComment,
  getComments,
};
