import { addPost } from "./post.js";

const startSkill = async (db, userID, skill) => {
  const [id, timestamp] = await addPost(
    db,
    userID,
    null,
    "",
    `${userID} has started working on ${skill}`,
    [skill]
  );
  const ref = await db.ref(`users/${userID}/skills`);
  await ref.push({
    skill: skill,
    startedAt: timestamp,
  });
  return timestamp;
};

const finishSkill = async (db, userID, skill, picture) => {
  const [id, timestamp] = await addPost(
    db,
    userID,
    picture,
    "",
    `${userID} has finished working on ${skill}`,
    [skill]
  );
  const ref = await db.ref(`users/${userID}/skills`);
  return await ref
    .orderByChild("skill")
    .equalTo(skill)
    .once("value")
    .then((skillRef) => {
      skillRef.forEach((sr) => {
        ref.child(sr.key).update({
          finishedAt: timestamp,
        });
      });
      return timestamp;
    });
};

export { startSkill, finishSkill };
