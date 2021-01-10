import { v4 as uuidv4 } from "uuid";

const getID = () => {
  return uuidv4();
};

const getTimestamp = () => {
  const date = new Date();
  return Math.round(date.getTime() / 1000);
};

export { getID, getTimestamp };
