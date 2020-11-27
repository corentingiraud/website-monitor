import * as functions from "firebase-functions";
import axios, { AxiosResponse } from "axios";
import { WEBSITE_LIST } from "./config/websites.list";
import { Website } from "./models/websites";

exports.checkWebsites = functions.https.onRequest(async (req, res) => {
  if (req.method !== "GET") {
    res.status(404).send();
    return;
  }

  console.log(req.headers.authorization);
  if (
    req.headers.authorization?.split(" ")[1] !==
    functions.config().monitor.password
  ) {
    res.status(403).send();
    return;
  }

  const websites: Website[] = [];
  const promises: Array<Promise<AxiosResponse>> = [];

  WEBSITE_LIST.forEach((website) => {
    promises.push(axios.options(website.url));
  });

  const results = await Promise.all(promises);

  results.forEach((response, i) => {
    if (response.status === 200) {
      websites.push({
        ...WEBSITE_LIST[i],
        isUp: true,
      });
    } else {
      websites.push({
        ...WEBSITE_LIST[i],
        isUp: false,
      });
    }
  });

  res.json(websites);
});
