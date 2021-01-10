import {v4 as uuidv4} from "uuid";

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

const addSkill = (db, userID, skillname, picture) => {
  const ref = db.ref(`users/${userID}/skills`);
  ref //todo!!!
    .orderByChild("skillname")
    .equalTo(skillname)
    .once("value")
    .then((snapshot) => {
      console.log(snapshot);
    });
};

const addPost = async (db, userID, title, tags, skill, post) => {
    const ref = db.ref(`users/${userID}/posts`);
    const id = uuidv4();
    await ref.push({
      postID: id,
      title: title,
      tags: tags,
      skill: skill,
      post: post,
    });
    return id;
  }  

const clap = (db, userID, clapperID, postID) => {
    const ref = db.ref(`users/${userID}/posts/${postID}`);
    ref.push(clapperID);
};

export { addFriend, editProfile, addPost, clap };