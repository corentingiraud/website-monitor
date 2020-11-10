const Koa = require('koa');
const Router = require('koa-router');
const cors = require('@koa/cors');
const axios = require('axios');


// CONFIG
const port = 3000;
const WEBSITE_LIST = [
  {
    name: 'MacoMaco',
    url: 'https://macomaco.studio',
  },
  {
    name: 'Amipbm',
    url: 'https://amipbm.fr',
  },
  {
    name: 'Declic',
    url: 'https://declic-solutions.org',
  }
];

const app = new Koa();
const router = new Router();

router.get('/websites', async (ctx) => {
  const websites = [];
  const promises = [];

  WEBSITE_LIST.forEach((website) => {
    promises.push(axios.get(website.url));
  });

  const results = await Promise.all(promises);

  results.forEach((res, i) => {
    if (res.status === 200) {
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

  console.log(websites);
  ctx.body = websites;
});

app.use(router.routes()).use(router.allowedMethods());
app.use(cors({
  origin: '*',
}));

app.listen(port);
