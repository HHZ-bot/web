'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"index.html": "c7abd37f72f736b9a7f8a8e4b7fe4309",
"/": "c7abd37f72f736b9a7f8a8e4b7fe4309",
"assets/NOTICES": "4115f68d4809b68cb574ecfcab9cff52",
"assets/assets/images/linux-app.png": "e2755f0fd6b7f88241290921653a5db0",
"assets/assets/images/ios-app.png": "843907a3153a07003066f02ef8d6b724",
"assets/assets/images/windows-app.png": "e2755f0fd6b7f88241290921653a5db0",
"assets/assets/images/home-bg-2.webp": "74c1ec7b74678981473368eaf0fcae69",
"assets/assets/images/android-app.png": "101cb78203a8058db3d1ef1a37bdbb6d",
"assets/assets/images/macos-app.png": "098e265992b7f8970a3af7e71f1ec2ca",
"assets/assets/images/home-bg-1.png": "21f1106d989c7b0526cbaa8947cc36ec",
"assets/assets/images/logocenter.webp": "e8dceb6cfb53ba25255a0781b41d7fb6",
"assets/assets/images/icon/android.svg": "3a2b6edc54436cce66ae42fe12c2898d",
"assets/assets/images/icon/android-appstore.svg": "1aec6db16e7542b28a7a3655e725c1ab",
"assets/assets/images/icon/macos-appstore.svg": "63a9e0e0dd8033c1c2c56f2e8dc5765c",
"assets/assets/images/icon/linuxkong.svg": "eb9d475bcf41adfaab89223193bab2f6",
"assets/assets/images/icon/telegram.svg": "79e5ac765638e586a5b0a335b1caac5e",
"assets/assets/images/icon/windows.svg": "22e4b817935832c8a729659d37d95615",
"assets/assets/images/icon/ios.svg": "1df918da775043978e7fb4d024e6a611",
"assets/assets/images/icon/macos.svg": "3e63eed218e79f79007a4d07a52dd159",
"assets/assets/images/icon/linux.svg": "ce1db44e5e5a0850cfe3b96305d87eb8",
"assets/assets/images/home-bg-3.webp": "17dd359f9f7790062830e9a3f8b653b8",
"assets/assets/themes/greyblue.json": "2b0d439313b256bb5d6778e17c7079c3",
"assets/assets/themes/gold.json": "fce0ad90d9a6a6d6c5cc86dcb979312a",
"assets/assets/themes/blue.json": "6ec88d582fc8fa54a040b02e1b5c32b1",
"assets/assets/themes/pink.json": "ae6a465c86b8b5af2602ba564e09d94f",
"assets/assets/themes/greylaw.json": "40305c6359d419e78bc8550670ef3d0a",
"assets/assets/themes/lime.json": "9bfccf9b2680989fa7f5b1f71fe6e2c1",
"assets/assets/themes/redwine.json": "9f0a8f3b3e924c38b67771316c142703",
"assets/assets/themes/red.json": "99d5191c9dd4caf5ecfa11ecce3fc899",
"assets/assets/themes/green.json": "b72ab9125a071ea38b3ab0e3994af8a4",
"assets/assets/themes/greenmoney.json": "16e888f3e1ba7a81b45e916a1848596b",
"assets/assets/themes/purple.json": "7a8a34602b9c3a3ca5be954d7dfdc611",
"assets/assets/translations/ru-RU.json": "d195a1bff90663dd64364ffc820efba9",
"assets/assets/translations/en-US.json": "a6a1ce6b848b835078ef70d1e90e4241",
"assets/assets/translations/fa_IR.json": "f0aa6084f6d32ae24eec0e97767a2080",
"assets/assets/translations/zh-CN.json": "35e4f9e6ce199403e649d77256fa9c57",
"assets/assets/translations/ps_AF.json": "9d8ba4d3e9afa4b233907e4e6fc622ff",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "4e88af599c4bcefd65e66b6c06e74acc",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.bin.json": "ec3044b2795751fcc790c2825d71e02c",
"assets/AssetManifest.json": "e26fe36ef0e5be732747c46b3b4f9822",
"version.json": "f17f10678b62196c38d1fc8b582e90d0",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"main.dart.js": "8e338686eb2745e10f5509c92ffd888d",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "901d86fb8842ec0d66225a542131d689",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter_bootstrap.js": "a5b08d2a0c907ec325a0c96f0ec261aa"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
