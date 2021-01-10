const clap = (db, userID, clapperID, postID) => {
    const ref = db.ref(`users/${userID}/posts/${postID}`);
    ref.push(clapperID);
};

export { clap };