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
  ref
    .orderByChild("skillname")
    .equalTo(skillname)
    .once("value")
    .then((snapshot) => {
      console.log(snapshot);
    });
};

export { addFriend, editProfile };
