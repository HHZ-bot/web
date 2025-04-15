// debuging?
const isDebuging = false;

//running on devel
const runOnDevelopment = false;

//const var
const appName = 'com.olddog';
const appVersion = '1.0.0';

const macOSMethodChannel = "com.example.olddog/macos";

const apiUrls = [
  "https://ctapi.pcpcp.site:28681",
  "https://ctapi.pcpcp.site:28681",
  "https://ctapi.pcpcp.site:28681",
  "https://v2api.pcpcp.site",
];

//show ip address
List<String> ipInfoSources = [
  "https://one.one.one.one/cdn-cgi/trace",
  "https://workers.dev/cdn-cgi/trace",
  "https://pages.dev/cdn-cgi/trace",
];

const helloUrl = "/v2/user/howareyou";

const sendMailUrl = "/v2/user/sendmail";
const registerUrl = "/v2/user/register";
const loginUrl = "/v2/user/login";
const logoutUrl = "/v2/user/logout";
const resetUrl = "/v2/user/password/reset";
const modifyByPasswordUrl = "/v2/user/password/modify/password";
const modifyByTokenUrl = "/v2/user/password/modify/token";
const checkinUrl = "/v2/user/checkin";
const checkinUrlV3 = "/v3/user/checkin";
const tokenUrl = "/v2/user/token/login";
const anonymousUrl = "/v2/user/anonymous/login";
const removeTokenUrl = "/v2/user/remove/token";
const setPromoCodeUrl = "/v2/user/set/promo/code";
const setCurrentPackageUrl = "/v2/user/set/current/package";
const addPackageDeviceUrl = "/v2/user/add/package/device";
const pushMyPackageUrl = "/v2/user/push/my/package";

const productsUrl = "/v2/user/products";
const cardRechargeUrl = "/v2/user/card/recharge";
const orderCreateUrl = "/v2/user/order/create";

const nodesUrl = "/v2/user/nodes";
const pushMyNodeUrl = "/v2/user/push/my/node";

const messagesUrl = "/v2/user/messages";
const messagesReadUrl = "/v2/user/messages/read";

const connectUrl = "/v2/user/connect";
const disconnectUrl = "/v2/user/disconnect";

RegExp emailRegex =
    RegExp(r"[A-Za-z0-9\._%+\-]+@[A-Za-z0-9\.\-]+\.[A-Za-z]{2,}");

RegExp passwordRegex = RegExp(r"^(.*).{6,}$");

RegExp verifyCodeRegex = RegExp(r"^\d{6}$");

RegExp validDomainRegex =
    RegExp(r"^(?:[a-z0-9](?:[a-z0-9\-]{0,61}[a-z0-9])?\.)+[a-z]{2,6}$");

const fernetPassword = 'cw_0x689RpI-jtRR7oE8h_eQsKImvJapLeSbXpwF4e4=';

const clashBaseURL = "http://127.0.0.1:19090";
const clashApiSecret = "";

const testDelayUrl = "https://cp.cloudflare.com/generate_204";
const testDelayTimeout = 2000;

const proUser = "ᴘʀᴏ";
const maxUser = "ᴍᴀx";
const ultraUser = "ᴜʟᴛ";

const norUserStar3 = "✰";
const proUserStar3 = "★★✰";
const maxUserStar3 = "★★★★★";
const ultUserStar3 = "★★★★★★★";

// const norUserStar = "✨";
// const proUserStar = "🌟";
// const maxUserStar = "💫";
// const ultUserStar = "💗";

const norUserStar = 'assets/images/user/putong.png';
const proUserStar = 'assets/images/user/huangjin.png';
const maxUserStar = 'assets/images/user/zhizun.png';
const ultUserStar = 'assets/images/user/bojin.png';

const freeUse = 0;
const normalUse = 3;
const advanceUse = 5;

//const clashApiSecret = "o6C4R9TU2nyBAasZrT1fgUMj";
//dns.yandex.ru secondary.dns.yandex.ru
//const ruDns = "77.88.8.8";
const ruDns = "udp://77.88.8.1";

//alidns tencentDns
//const cnDns = "119.29.29.29";
const cnDns = "udp://223.5.5.5";

//iran
//const irDns = "2.189.44.44";
const irDns = "udp://5.200.200.200";

//afghanistan
//const afDns = "74.118.82.29";
const afDns = "udp://180.94.94.195";
