import 'package:webpig/models/funversion_model.dart';
import 'package:webpig/models/funproduct_model.dart';

// debuging?
const isDebuging = false;

//running on devel
const runOnDevelopment = false;

//const var
const appName = 'com.olddog';
const appVersion = '1.0.0';

const apiUrls = [
  "https://ctapi.pcpcp.site:28681",
  "https://ctapi.pcpcp.site:28681",
  "https://ctapi.pcpcp.site:28681",
  "https://v2api.pcpcp.site",
];

const telegramlink = 'https://t.me/+m0HSPHDNhLpkMGM1'; //空隐藏
List<Funversion> supportplatform = [
  Funversion(
    id: 1,
    platform: 'ios',
    minimum: '11.0',
    suggest: '12.0',
    badge: 'Beta',
    downloadUrl: 'https://example.com/ios/download',
    paySwitch: false,
  ),
  Funversion(
    id: 2,
    platform: 'android',
    minimum: '5.0',
    suggest: '6.0',
    badge: 'Stable',
    downloadUrl: 'https://example.com/android/download',
    paySwitch: true,
  ),
  Funversion(
    id: 3,
    platform: 'windows',
    minimum: '10',
    suggest: '11',
    badge: 'Release',
    downloadUrl: 'https://example.com/windows/download',
    paySwitch: true,
  ),
  Funversion(
    id: 4,
    platform: 'macos',
    minimum: '10.13',
    suggest: '10.14',
    badge: 'Stable',
    downloadUrl: 'https://example.com/macos/download',
    paySwitch: true,
  ),
  Funversion(
    id: 5,
    platform: 'linux',
    minimum: 'Ubuntu 18.04',
    suggest: 'Ubuntu 20.04',
    badge: 'Experimental',
    downloadUrl: 'https://example.com/linux/download',
    paySwitch: false,
  ),
];
List<Funproduct> funproducts = [
  Funproduct(
    id: 1,
    productLevle: 3,
    productName: "Week Pro",
    productDetail: "a week time",
    productTime: 604800,
    productValue: 200,
    discountStart: "2024-01-01 00:00:00",
    discountStop: "2026-05-01 00:00:00",
    discountValue: 50,
  ),
  Funproduct(
    id: 2,
    productLevle: 3,
    productName: "Month Pro",
    productDetail: "a month time",
    productTime: 2592000,
    productValue: 512,
    productBanner: "Popular",
    discountStart: "2025-05-01 00:00:00",
    discountStop: "2025-09-03 00:00:00",
    discountValue: 100,
  ),
  Funproduct(
    id: 3,
    productLevle: 3,
    productName: "SemiAnnual Pro",
    productDetail: "semiannual time",
    productTime: 15552000,
    productValue: 3289,
    discountStart: "2024-09-01 00:00:00",
    discountStop: "2024-12-31 23:59:59",
    discountValue: 500,
  ),
  Funproduct(
    id: 4,
    productLevle: 3,
    productName: "Annual Pro",
    productDetail: "annual time",
    productTime: 31104000,
    productValue: 6999,
    productBanner: "Best Value",
    discountStart: "2024-03-01 00:00:00",
    discountStop: "2024-09-01 00:00:00",
    discountValue: 1000,
  ),
  Funproduct(
    id: 5,
    productLevle: 5,
    productName: "Month Ultra",
    productDetail: "a month time",
    productTime: 2592000,
    productValue: 700,
    discountValue: 0,
  ),
  Funproduct(
    id: 6,
    productLevle: 5,
    productName: "SemiAnnual Ultra",
    productDetail: "semiannual time",
    productTime: 15552000,
    productValue: 4230,
    discountStart: "2024-08-01 00:00:00",
    discountStop: "2024-09-01 00:00:00",
    discountValue: 700,
  ),
  Funproduct(
    id: 7,
    productLevle: 5,
    productName: "Annual Ultra",
    productDetail: "annual time",
    productTime: 31104000,
    productValue: 8400,
    discountValue: 0,
  ),
];
// 表头文本列表
List<String> footerheaderTitles = [
  'useragreement',
  'downloadsoft',
  'aboutuse',
  'siteguide'
];
List<List<Map<String, String>>> footerlist = [
  // 第一行：用户条例、iphone、常见问题、官方微博
  [
    {'text': 'userrules', 'link': 'https://example.com/rules'},
    {'text': 'ios', 'link': 'jump_download'},
    {'text': 'faq', 'link': 'https://example.com/faq'},
    {'text': 'officalcontect', 'link': 'https://weibo.com/official'},
  ],
  // 第二行：隐藏政策、android、公告中心、防失联
  [
    {'text': 'privacypolicy', 'link': 'https://example.com/privacy'},
    {'text': 'android', 'link': 'https://example.com/android'},
    {'text': 'help', 'link': 'https://example.com/announcement'},
    {'text': 'gitlose', 'link': 'https://example.com/no-disconnect'},
  ],
  // 第三行：macos、windows、会员价格
  [
    {'text': '', 'link': ''},
    {'text': 'macos', 'link': 'https://example.com/macos'},
    {'text': 'payment', 'link': 'https://example.com/price'},
    {'text': '', 'link': ''},
  ],
  // 第四行：windows
  [
    {'text': '', 'link': ''},
    {'text': 'windows', 'link': 'https://example.com/macos'},
    {'text': '', 'link': ''},
    {'text': '', 'link': ''},
  ],
  [
    {'text': '', 'link': ''},
    {'text': 'linux', 'link': 'https://example.com/macos'},
    {'text': '', 'link': ''},
    {'text': '', 'link': ''},
  ],
];

RegExp emailRegex =
    RegExp(r"[A-Za-z0-9\._%+\-]+@[A-Za-z0-9\.\-]+\.[A-Za-z]{2,}");

RegExp passwordRegex = RegExp(r"^(.*).{6,}$");

RegExp verifyCodeRegex = RegExp(r"^\d{6}$");

RegExp validDomainRegex =
    RegExp(r"^(?:[a-z0-9](?:[a-z0-9\-]{0,61}[a-z0-9])?\.)+[a-z]{2,6}$");
