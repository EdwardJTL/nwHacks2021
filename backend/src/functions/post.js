import {
  convertTimestampToDate,
  getID,
  getTimestamp,
  initializeSkillMap,
} from "./helper.js";
import { getFriends } from "./friend.js";

const addPost = async (db, userID, picture, content, title, tags, shared) => {
  const ref = await db.ref(`users/${userID}/posts`);
  const id = getID();
  const timestamp = getTimestamp();
  ref.push({
    postID: id,
    picture: picture,
    claps: 0,
    content: content,
    title: title,
    tags: tags,
    shared: shared,
    postedAt: timestamp,
    skill: initializeSkillMap()[tags[0]],
  });
  return [id, timestamp];
};

const addClap = async (db, posterID, postID) => {
  const ref = await db.ref(`users/${posterID}/posts`);
  await ref
    .orderByChild("postID")
    .equalTo(postID)
    .once("value")
    .then(async (post) => {
      await post.forEach((postRef) => {
        ref.child(postRef.key).update({
          claps: postRef.child("claps").val() + 1,
        });
      });
    });
  return true;
};

const addComment = async (db, commenterID, comment, posterID, postID) => {
  const ref = await db.ref(`users/${posterID}/posts`);
  return await ref
    .orderByChild("postID")
    .equalTo(postID)
    .once("value")
    .then(async (post) => {
      const id = getID();
      const timestamp = getTimestamp();
      await post.forEach((postRef) => {
        ref.child(`${postRef.key}/comments`).push({
          commenterID: commenterID,
          commentID: id,
          comment: comment,
          postedAt: timestamp,
        });
      });
      return [id, timestamp];
    });
};

const getPosts = async (db, userID) => {
  const ref = db.ref(`users/${userID}/posts`);
  return await ref.once("value").then(async (snapshot) => {
    const posts = [];
    await snapshot.forEach((post) => {
      post = post.toJSON();
      console.log(post);
      if (!post["shared"]) {
        return;
      }
      const tags = [];
      for (const key in post["tags"]) {
        tags.push(post["tags"][key]);
      }
      post["tags"] = tags;
      post["posterID"] = userID;
      post["postedAt"] = convertTimestampToDate(post["postedAt"]);
      posts.push(post);
    });
    posts.sort((a, b) => b["postedAt"] - a["postedAt"]);
    return posts;
  });
};

const getNewsfeed = async (db, userID) => {
  const friends = await getFriends(db, userID);
  console.log(friends);
  let posts = [];
  for (const friendID of friends) {
    const friendPosts = await getPosts(db, friendID);
    console.log(friendPosts);
    posts = posts.concat(friendPosts);
  }
  posts.sort((a, b) => b["postedAt"] - a["postedAt"]);
  return posts;
};

const getComments = async (db, posterID, postID) => {
  const ref = db.ref(`users/${posterID}/posts`);
  return await ref
    .orderByChild("postID")
    .equalTo(postID)
    .once("value")
    .then(async (post) => {
      const comments = [];
      await post.forEach((postRef) => {
        const commentJSON = postRef.toJSON()["comments"];
        for (const key in commentJSON) {
          commentJSON[key]["postedAt"] = convertTimestampToDate(
            commentJSON[key]["postedAt"]
          );
          comments.push(commentJSON[key]);
        }
      });
      comments.sort((a, b) => b["postedAt"] - a["postedAt"]);
      return comments;
    });
};

export { addPost, addClap, addComment, getPosts, getNewsfeed, getComments };
