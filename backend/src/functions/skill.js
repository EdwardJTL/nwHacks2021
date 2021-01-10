import { convertTimestampToDate } from "./helper.js";
import { addPost } from "./post.js";

const startSkill = async (db, userID, skill) => {
  const [id, timestamp] = await addPost(
    db,
    userID,
    null,
    "",
    `${userID} has started working on ${skill}`,
    [skill],
    true
  );
  const ref = await db.ref(`users/${userID}/skills`);
  await ref.push({
    skill: skill,
    startedAt: timestamp,
    completed: false,
  });
  return timestamp;
};

const finishSkill = async (
  db,
  userID,
  skill,
  picture,
  title,
  content,
  shared
) => {
  const [id, timestamp] = await addPost(
    db,
    userID,
    picture,
    content,
    title,
    [skill],
    shared
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
          completed: true,
        });
      });
      return timestamp;
    });
};

const getSkills = async (db, userID) => {
  const ref = await db.ref(`users/${userID}/skills`);
  return await ref.once("value").then(async (snapshot) => {
    const skills = [];
    await snapshot.forEach((skill) => {
      skill = skill.toJSON();
      skill["startedAt"] = convertTimestampToDate(skill["startedAt"]);
      skill["finishedAt"] = convertTimestampToDate(skill["finishedAt"]);
      skills.push(skill);
    });
    return skills;
  });
};

export { startSkill, finishSkill, getSkills };
