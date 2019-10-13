var cacheName = "csound-live-code-15";
var filesToCache = [
  "/",
  "/index.html",
  "/web/codemirror.css",
  "/web/theme/monokai.css",
  "/web/cslivecode.css",
  "/web/codemirror.js",
  "/web/mode/csound/csound.js",
  "/web/addon/comment/comment.js",
  "/web/addon/edit/matchbrackets.js",
  "/web/addon/edit/closebrackets.js",
  "/web/keymap/vim.js",
  "/web/keymap/emacs.js",
  "/web/cslivecode.js",
  "/web/csound/CsoundNode.js",
  "/web/csound/CsoundObj.js",
  "/web/csound/CsoundProcessor.js",
  "/web/csound/CsoundScriptProcessorNode.js",
  "/web/csound/libcsound-worklet.js",
  "/web/csound/libcsound.js",
  "/livecode.orc",
  "/start.orc",
  "https://fonts.googleapis.com/css?family=Raleway|Roboto:400,700",
  "https://use.fontawesome.com/releases/v5.1.1/css/all.css",
  "https://code.jquery.com/jquery-1.11.1.min.js",
  "https://golden-layout.com/files/latest/js/goldenlayout.min.js",
  "https://golden-layout.com/files/latest/css/goldenlayout-base.css",
  "https://golden-layout.com/files/latest/css/goldenlayout-dark-theme.css"
];

self.addEventListener("install", function(e) {
  console.log("[ServiceWorker] Install");
  e.waitUntil(
    caches.open(cacheName).then(function(cache) {
      console.log("[ServiceWorker] Caching app shell");
      return cache.addAll(filesToCache);
    })
  );
});

self.addEventListener("activate", function(e) {
  console.log("[ServiceWorker] Activate");
  e.waitUntil(
    caches.keys().then(function(keyList) {
      return Promise.all(
        keyList.map(function(key) {
          if (key !== cacheName) {
            console.log("[ServiceWorker] Removing old cache", key);
            return caches.delete(key);
          }
        })
      );
    })
  );
  return self.clients.claim();
});

self.addEventListener("fetch", function(e) {
  console.log("[ServiceWorker] Fetch", e.request.url);
  e.respondWith(
    // Cache then Network
    //caches.match(e.request).then(function(response) {
    //  return response || fetch(e.request);
    //})

    // Network then Cache
    fetch(e.request).catch(function() {
      return caches.match(e.request);
    })
  );
});
