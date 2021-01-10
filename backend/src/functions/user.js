const editProfile = async (db, userID, name, biography, interests) => {
  const ref = await db.ref(`/users/${userID}`);
  await ref.update({
    name: name,
    biography: biography,
    interests: interests,
  });
  return true;
};

const getProfile = async (db, userID) => {
  const ref = await db.ref(`/users/${userID}`);
  return await ref.once("value").then((snapshot) => {
    const interests = [];
    snapshot = snapshot.toJSON();
    for (const key in snapshot["interests"]) {
      interests.push(snapshot["interests"][key]);
    }
    return {
      userID: userID,
      name: snapshot["name"],
      biography: snapshot["biography"],
      interests: interests,
      streak: 5,
    };
  });
};

export { editProfile, getProfile };
