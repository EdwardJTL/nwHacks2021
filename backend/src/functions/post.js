import { getID, getTimestamp } from "./helper.js";
import { getFriends } from "./friend.js";

const addPost = async (db, userID, picture, content, title, tags) => {
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
    postedAt: timestamp,
  });
  return [id, timestamp];
};

const addClap = async (db, posterID, postID) => {
  const ref = await db.ref(`users/${posterID}/posts`);
  await ref
    .orderByChild("postID")
    .equalTo(postID)
    .once("value")
    .then((post) => {
      ref.child(post.key).update({
        claps: post.child("claps") + 1,
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
    .then((post) => {
      const id = getID();
      const timestamp = getTimestamp();
      ref.child(`${post.key}/comments`).push({
        commenterID: commenterID,
        commentID: id,
        comment: comment,
        postedAt: timestamp,
      });
      return [id, timestamp];
    });
};

const getPosts = async (db, userID) => {
  const ref = db.ref(`users/${userID}/posts`);
  return await ref.once("value").then(async (snapshot) => {
    const posts = [];
    await snapshot.forEach((post) => {
      posts.push(post.toJSON());
    });
    return posts;
  });
};

const getNewsfeed = async (db, userID) => {
  const friends = await getFriends(db, userID);
  let posts = [];
  await friends.forEach(async (friendID) => {
    const friendPosts = getPosts(db, friendID);
    posts = posts.concat(friendPosts);
  });
  return posts;
};

const getComments = async (db, posterID, postID) => {
  const ref = db.ref(`users/${posterID}/posts`);
  return await ref
    .orderByChild("postID")
    .equalTo(postID)
    .once("value")
    .then((post) => {
      const comments = [];
      await post.child("comments").forEach((comment) => {
        comments.push(comment);
      });
      return comments;
    });
};

export { addPost, addClap, addComment, getNewsfeed, getComments };
