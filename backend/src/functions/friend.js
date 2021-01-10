const getFriends = async (db, userID) => {
  const ref = await db.ref(`users/${userID}/friends`);
  const friends = await ref.once("value").then(async (snapshot) => {
    const allFriends = [];
    await snapshot.forEach((friend) => {
      allFriends.push(friend.val());
    });
    return allFriends;
  });
  return friends;
};

const addFriend = async (db, userID, friendID) => {
  const ref = await db.ref(`users/${userID}/friends`);
  ref.push(friendID);
  return true;
};

export { getFriends, addFriend };
