import { v4 as uuidv4 } from "uuid";

const getID = () => {
  return uuidv4();
};

const getTimestamp = () => {
  const date = new Date();
  return Math.round(date.getTime() / 1000);
};

const convertTimestampToDate = (timestamp) => {
  if (!timestamp) {
    return null;
  }
  return timestamp;
  //   const date = new Date(timestamp * 1000);
  //   return date.toString();
};

const initializeSkillMap = () => {
  const skills = [
    "drawing",
    "painting",
    "calligraphy",
    "knitting",
    "bullet journal",
    "piano",
  ];
  const skillMap = {};
  for (const skill of skills) {
    skillMap[skill] = {
      name: skill,
      description: "A new skill for the new year!",
      completedCount: Math.round(Math.random() * 100) + 1,
      creatorUserID: "keyr",
      image: "",
    };
  }
  console.log(skillMap);
  return skillMap;
};

export { getID, getTimestamp, convertTimestampToDate, initializeSkillMap };
