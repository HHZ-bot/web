import '../models/funversion_model.dart';

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

const telechannel = 'aa'; //空隐藏
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

RegExp emailRegex =
    RegExp(r"[A-Za-z0-9\._%+\-]+@[A-Za-z0-9\.\-]+\.[A-Za-z]{2,}");

RegExp passwordRegex = RegExp(r"^(.*).{6,}$");

RegExp verifyCodeRegex = RegExp(r"^\d{6}$");

RegExp validDomainRegex =
    RegExp(r"^(?:[a-z0-9](?:[a-z0-9\-]{0,61}[a-z0-9])?\.)+[a-z]{2,6}$");
