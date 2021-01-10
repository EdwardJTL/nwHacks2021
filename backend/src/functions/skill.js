

const clap = (db, userID, posts) => {
    const ref = db.ref(`users/${userID}/friends`);
    ref.push(friendID);
  };
  