'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"manifest.json": "0867c3e13649ac4d06fe34b7b3ddce08",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.wasm": "4ee7ac34b3640765be9911bca9c97341",
"flutter_bootstrap.js": "b7d7281626ac65c7dc49932a5428af40",
"version.json": "ff966ab969ba381b900e61629bfb9789",
"index.html": "278a4df0af7b7e49eb0e312e3a34e77b",
"/": "278a4df0af7b7e49eb0e312e3a34e77b",
"main.dart.mjs": "0c9efedf31af70e10efdbff4ae88e63f",
"main.dart.js": "fbb652ad9cd1bbcb43deb54abec9fb7d",
"assets/AssetManifest.json": "f0d9449e01e90a629552154ef83c7c55",
"assets/packages/flutter_element_ui/assets/icons/notification.svg": "9659441145ed9fcb465e973b41a0d75f",
"assets/packages/flutter_element_ui/assets/icons/gold-medal.svg": "0979666f1b6bef9176e2afafb814ac9c",
"assets/packages/flutter_element_ui/assets/icons/eleme-filled.svg": "81d236ddc2181a261e53f35cf0860b7a",
"assets/packages/flutter_element_ui/assets/icons/sort-down.svg": "2f76a3b1b5205ac1d4415e8c56908be2",
"assets/packages/flutter_element_ui/assets/icons/compass.svg": "58a0a464ba2df931435da1796c77ad82",
"assets/packages/flutter_element_ui/assets/icons/check.svg": "75804551bc20b01aa6a2a22be568a2e0",
"assets/packages/flutter_element_ui/assets/icons/bottom-left.svg": "131d81d707d1dae1f17bd1ed6a949e94",
"assets/packages/flutter_element_ui/assets/icons/top-left.svg": "0ea7020213b19164f02eb62cf9d544a6",
"assets/packages/flutter_element_ui/assets/icons/video-pause.svg": "371f6d31fc06f138990708e541d7e300",
"assets/packages/flutter_element_ui/assets/icons/baseball.svg": "84341decdc7513c6fea78f8d249e59b0",
"assets/packages/flutter_element_ui/assets/icons/select.svg": "ad66785a1576c22d3aefde662d1e0d99",
"assets/packages/flutter_element_ui/assets/icons/credit-card.svg": "861dd1d596c53c242b0a8310373cb1fe",
"assets/packages/flutter_element_ui/assets/icons/moon-night.svg": "158f0f2d88f0612cb256fcfa86d26df9",
"assets/packages/flutter_element_ui/assets/icons/phone.svg": "ca086cdf443748ceb768ce3db64415c4",
"assets/packages/flutter_element_ui/assets/icons/video-camera-filled.svg": "e3a9080ea6203a1def72ce221a2355ec",
"assets/packages/flutter_element_ui/assets/icons/list.svg": "cc79a832b5294dbd6e5915b384001c57",
"assets/packages/flutter_element_ui/assets/icons/ice-cream.svg": "8aea6cd206bd9377816dc08d319e18c2",
"assets/packages/flutter_element_ui/assets/icons/mute.svg": "9713f46c1bbab56f49b4f0a110f1999e",
"assets/packages/flutter_element_ui/assets/icons/opportunity.svg": "308b9c0fc0495d4e7bc6358a78267d40",
"assets/packages/flutter_element_ui/assets/icons/dish.svg": "092905a8df01a266ab92fc33477655e9",
"assets/packages/flutter_element_ui/assets/icons/suitcase.svg": "ced507f8526d10807a9ce1c7f1192eb8",
"assets/packages/flutter_element_ui/assets/icons/bicycle.svg": "7c698d68bffd1dc6cfd35c52aceecde5",
"assets/packages/flutter_element_ui/assets/icons/switch-filled.svg": "1c4014ed37fb6f61e0cfe7a95ccce113",
"assets/packages/flutter_element_ui/assets/icons/pear.svg": "d2955077ace9febe24a25b522fd5edaa",
"assets/packages/flutter_element_ui/assets/icons/box.svg": "3f24079169da7afdab1c3e586c194302",
"assets/packages/flutter_element_ui/assets/icons/timer.svg": "433fce1e5ba5c377a39fae7780a34e51",
"assets/packages/flutter_element_ui/assets/icons/apple.svg": "8e665e467a2ee9bccc570d6d987c7a72",
"assets/packages/flutter_element_ui/assets/icons/goblet-square-full.svg": "83fd78aada31675727cedb460dde2629",
"assets/packages/flutter_element_ui/assets/icons/watermelon.svg": "34e81c7835156cf982600f6c40fc38c1",
"assets/packages/flutter_element_ui/assets/icons/plus.svg": "602cef3130d9742d8db30005670061a9",
"assets/packages/flutter_element_ui/assets/icons/office-building.svg": "513e8837dabe326360b0064f9b873a06",
"assets/packages/flutter_element_ui/assets/icons/male.svg": "339609a999bdf8be1de265bfd79d74ce",
"assets/packages/flutter_element_ui/assets/icons/finished.svg": "9375bad8ea3acaf4c62a9b380c50cfbc",
"assets/packages/flutter_element_ui/assets/icons/key.svg": "57844661145d63f4f6f8faa756e7190d",
"assets/packages/flutter_element_ui/assets/icons/stopwatch.svg": "ec1927a1790ee82721a7d5cdccba0e0a",
"assets/packages/flutter_element_ui/assets/icons/warning.svg": "1dda7c17abd37c262cd6f5e2ef8884d3",
"assets/packages/flutter_element_ui/assets/icons/info-filled.svg": "1d77bbce1ea46eed6264b349053343f7",
"assets/packages/flutter_element_ui/assets/icons/document-add.svg": "7a6f06ada145c380543ab0c158aa653c",
"assets/packages/flutter_element_ui/assets/icons/menu.svg": "40c0e57f8e1e924a0ca3d8dfe13cfda1",
"assets/packages/flutter_element_ui/assets/icons/price-tag.svg": "98fb21beb35a28a5a1510320fdb02b1b",
"assets/packages/flutter_element_ui/assets/icons/refresh-right.svg": "df63300fba1e1a45c730f74b51399af1",
"assets/packages/flutter_element_ui/assets/icons/goods-filled.svg": "e898248572d3a731d52c1f561ab28471",
"assets/packages/flutter_element_ui/assets/icons/top.svg": "5df79431f0b59e368f81094c1b9a5d83",
"assets/packages/flutter_element_ui/assets/icons/message-box.svg": "3debf7f7b57db5eb20d4fcd7f6258ee2",
"assets/packages/flutter_element_ui/assets/icons/sunny.svg": "6e7957b3db95dcae0b4c3911e56fa8ba",
"assets/packages/flutter_element_ui/assets/icons/warning-filled.svg": "ea6a19288a21f598f622964852dbcccc",
"assets/packages/flutter_element_ui/assets/icons/clock.svg": "1f62553751ec43c8ff78777242b6cd15",
"assets/packages/flutter_element_ui/assets/icons/document-delete.svg": "7a55db36fb9e51cd1c9b94b9e52e660a",
"assets/packages/flutter_element_ui/assets/icons/document.svg": "441e3179c6dbcc98a489cb33b2817687",
"assets/packages/flutter_element_ui/assets/icons/refresh.svg": "0e5256fb6d885854689ed2e7b03af488",
"assets/packages/flutter_element_ui/assets/icons/histogram.svg": "5955e07d07f6adb08e177c6d0f911c80",
"assets/packages/flutter_element_ui/assets/icons/coordinate.svg": "54de1cb13623fd146a753e58cc42b318",
"assets/packages/flutter_element_ui/assets/icons/chat-dot-square.svg": "4fa15edbab2797c23ad754ea3fafdfc9",
"assets/packages/flutter_element_ui/assets/icons/lollipop.svg": "307712057f7b2fe68cd5132add241953",
"assets/packages/flutter_element_ui/assets/icons/avatar.svg": "3fc679cfd4f45a8a1765048ebdd4fdbe",
"assets/packages/flutter_element_ui/assets/icons/milk-tea.svg": "3f2f39472d01f756d5c5655d039fabab",
"assets/packages/flutter_element_ui/assets/icons/circle-plus.svg": "9c421c327b1045f0ccc40e40f5f2fa9c",
"assets/packages/flutter_element_ui/assets/icons/turn-off.svg": "8d7f22b513b0b7a0a71268009a3489f1",
"assets/packages/flutter_element_ui/assets/icons/bell-filled.svg": "16af9cdf5e8db595f2484c5341390a48",
"assets/packages/flutter_element_ui/assets/icons/medal.svg": "9544b8459dbcf5a6b87468a2b8993f71",
"assets/packages/flutter_element_ui/assets/icons/notebook.svg": "91a3485b12ceb173fd22d2bfeb61e13b",
"assets/packages/flutter_element_ui/assets/icons/more.svg": "f3b07565e353cb8039101e91ecd06e97",
"assets/packages/flutter_element_ui/assets/icons/fold.svg": "eca1a4b537dba1f35f629564df58b1e5",
"assets/packages/flutter_element_ui/assets/icons/house.svg": "b6ad4767e222f84cf007edfe1e096a77",
"assets/packages/flutter_element_ui/assets/icons/folder-remove.svg": "f64bf42723c5c178ee3594eedcbebb11",
"assets/packages/flutter_element_ui/assets/icons/refrigerator.svg": "0e2fb0c9bedb7b36af2aca0ed6226f07",
"assets/packages/flutter_element_ui/assets/icons/basketball.svg": "5068b228f4d830530977e0799f197066",
"assets/packages/flutter_element_ui/assets/icons/postcard.svg": "b396a70959d75e52dc33d543a733acb7",
"assets/packages/flutter_element_ui/assets/icons/wind-power.svg": "85b9b978d6ee11901a8840b5b875a9b0",
"assets/packages/flutter_element_ui/assets/icons/home-filled.svg": "aaa851880ed69b9cba7084b0b8c0cbd6",
"assets/packages/flutter_element_ui/assets/icons/zoom-out.svg": "3ad328fa994f99728891dba2db8c7fd6",
"assets/packages/flutter_element_ui/assets/icons/briefcase.svg": "f125837c21c4f3a859fe5b82e3c8f1aa",
"assets/packages/flutter_element_ui/assets/icons/scale-to-original.svg": "1323932262824fbe81aa41166602bccd",
"assets/packages/flutter_element_ui/assets/icons/goblet-full.svg": "8f22bf3314606ef8fd9696ded2c00ea0",
"assets/packages/flutter_element_ui/assets/icons/pouring.svg": "595f493b00844d9f519e6ab43392d878",
"assets/packages/flutter_element_ui/assets/icons/printer.svg": "51799dba6a4feb9d4f62cb11be3e5da0",
"assets/packages/flutter_element_ui/assets/icons/van.svg": "0a0d7d7485087459255182ad96d375ab",
"assets/packages/flutter_element_ui/assets/icons/calendar.svg": "466ab529104bc2c0abc52aed466e0466",
"assets/packages/flutter_element_ui/assets/icons/guide.svg": "b63faeb56955240093faca32e8d351c8",
"assets/packages/flutter_element_ui/assets/icons/goblet-square.svg": "0313a9e71d797649b08dced4959e7d25",
"assets/packages/flutter_element_ui/assets/icons/headset.svg": "4e9e99bbb86dce10c62c78e147f4b274",
"assets/packages/flutter_element_ui/assets/icons/location-information.svg": "a9bee74135623f934786f5fc560a01fc",
"assets/packages/flutter_element_ui/assets/icons/shopping-trolley.svg": "0a2197532bc75e8ed8b6ad56fc04f287",
"assets/packages/flutter_element_ui/assets/icons/back.svg": "2fe19ed557b443b3b5bb63b573decd55",
"assets/packages/flutter_element_ui/assets/icons/element-plus.svg": "b6333ece6943901a2b3cd2a4d0aba3b7",
"assets/packages/flutter_element_ui/assets/icons/delete-location.svg": "7fe9182235a70a3af8a4db1805154aae",
"assets/packages/flutter_element_ui/assets/icons/arrow-right-bold.svg": "5f25118c956dee91a1263d3c61d4d608",
"assets/packages/flutter_element_ui/assets/icons/expand.svg": "b11e5bcfc397266b5f3dcd2e22d630c7",
"assets/packages/flutter_element_ui/assets/icons/more-filled.svg": "701003128b45afc61992e32c915a0f6b",
"assets/packages/flutter_element_ui/assets/icons/no-smoking.svg": "5e4ea4fd5c35bcec437f01a3a37981b5",
"assets/packages/flutter_element_ui/assets/icons/arrow-left-bold.svg": "1f68686c0718e468eb9168c69158ca9c",
"assets/packages/flutter_element_ui/assets/icons/video-camera.svg": "4841e175f277abdbc045d0b107c348b5",
"assets/packages/flutter_element_ui/assets/icons/chrome-filled.svg": "c267cd40cd1bca0e672523e242a3f4ae",
"assets/packages/flutter_element_ui/assets/icons/star-filled.svg": "fd6c807fb87d641db6f2153349038319",
"assets/packages/flutter_element_ui/assets/icons/d-arrow-right.svg": "8ad689861674324e37d155c933fe465a",
"assets/packages/flutter_element_ui/assets/icons/arrow-down.svg": "4ceb1b0299c71bee2a7c5c4ab76ad5ef",
"assets/packages/flutter_element_ui/assets/icons/partly-cloudy.svg": "3fdd2aa2aed631c332ad9f0a071c673c",
"assets/packages/flutter_element_ui/assets/icons/help.svg": "743b9f3bd3f6a5d35ac1b59482b0df0b",
"assets/packages/flutter_element_ui/assets/icons/ice-drink.svg": "1439f3023550f6b4f05be4e3d7d4c42e",
"assets/packages/flutter_element_ui/assets/icons/filter.svg": "a64412147b0152dde0f52abdcacee395",
"assets/packages/flutter_element_ui/assets/icons/upload.svg": "d5ec8e3213ef8932cd02c9c3c1b67327",
"assets/packages/flutter_element_ui/assets/icons/user-filled.svg": "0e682ff273772da957643deb77763b9b",
"assets/packages/flutter_element_ui/assets/icons/pie-chart.svg": "e0344ec86f3ee23734e14cd1a0da7544",
"assets/packages/flutter_element_ui/assets/icons/wallet.svg": "5856a7d25cafc4b3621c2df7f6a70b29",
"assets/packages/flutter_element_ui/assets/icons/scissor.svg": "a24792a8e8edd264f4c3a93236010a56",
"assets/packages/flutter_element_ui/assets/icons/bowl.svg": "669bb4864e3c4a9e5c3eab98a13998bb",
"assets/packages/flutter_element_ui/assets/icons/circle-plus-filled.svg": "098b13486204d82c2de1bf92d4fa4640",
"assets/packages/flutter_element_ui/assets/icons/video-play.svg": "376b25b8687da90104e149fc8f934db9",
"assets/packages/flutter_element_ui/assets/icons/tickets.svg": "51c405197328b41b0b96d3f8a211583e",
"assets/packages/flutter_element_ui/assets/icons/success-filled.svg": "911b8cd29d3f5e05336baf0ee66e99f2",
"assets/packages/flutter_element_ui/assets/icons/link.svg": "8d6b6f824bdd3e07b679bf95c795d250",
"assets/packages/flutter_element_ui/assets/icons/money.svg": "46ce06497efc5013942ff9948de968a6",
"assets/packages/flutter_element_ui/assets/icons/female.svg": "3a3ab25f51e3b33982a73aecf15d2f37",
"assets/packages/flutter_element_ui/assets/icons/location-filled.svg": "6c2a06434611c4d349178ac16166c67d",
"assets/packages/flutter_element_ui/assets/icons/arrow-up.svg": "aed1e2d25f62b119d71002a9cb990720",
"assets/packages/flutter_element_ui/assets/icons/top-right.svg": "fc5d13a1844609934a75359868e7cb61",
"assets/packages/flutter_element_ui/assets/icons/unlock.svg": "3d536bf2dddad31b5f4f49d5c1dca319",
"assets/packages/flutter_element_ui/assets/icons/view.svg": "ef66ca6004d132012e141f5049ad9f61",
"assets/packages/flutter_element_ui/assets/icons/question-filled.svg": "3d988daf8547a781369885b721daec90",
"assets/packages/flutter_element_ui/assets/icons/flag.svg": "aee38d47cff7466e8f587c7c01c0c278",
"assets/packages/flutter_element_ui/assets/icons/chat-round.svg": "ca92da71664a06f06f5b369f1a4ac0ee",
"assets/packages/flutter_element_ui/assets/icons/mic.svg": "67cddcb4d776b36e65a72970edff606c",
"assets/packages/flutter_element_ui/assets/icons/shopping-bag.svg": "db6aab21e7b3e28793c20e2cc0a81597",
"assets/packages/flutter_element_ui/assets/icons/bell.svg": "29e599b545d49a4fced0bd874d6935f9",
"assets/packages/flutter_element_ui/assets/icons/dish-dot.svg": "4f742ef8357178bcf9866fdd92bd7e63",
"assets/packages/flutter_element_ui/assets/icons/lightning.svg": "ebcf608ea79de64de45c4c7bdefd6040",
"assets/packages/flutter_element_ui/assets/icons/open.svg": "d19b38b3c58e0e38f7b37697a9a9c4d1",
"assets/packages/flutter_element_ui/assets/icons/first-aid-kit.svg": "02afca941b022625f5ca787df488ec97",
"assets/packages/flutter_element_ui/assets/icons/bottom.svg": "e393eb7b181b34c8a789972e0fb79f88",
"assets/packages/flutter_element_ui/assets/icons/microphone.svg": "e9e7e597b4deb5e8164a126c179715ea",
"assets/packages/flutter_element_ui/assets/icons/stamp.svg": "9a392e1ffd1bdd28e332fbe423d3709e",
"assets/packages/flutter_element_ui/assets/icons/iphone.svg": "198e3e366a15eccedd9df6c421365bda",
"assets/packages/flutter_element_ui/assets/icons/chat-line-square.svg": "78c6d413f802bfb114442fb32a608e8a",
"assets/packages/flutter_element_ui/assets/icons/mute-notification.svg": "55742af95d8313ab6082638b292acca5",
"assets/packages/flutter_element_ui/assets/icons/trophy-base.svg": "54c333bb06ed513aa3a34899c167f5ad",
"assets/packages/flutter_element_ui/assets/icons/arrow-down-bold.svg": "58aecc93799bac666b10824011357dc2",
"assets/packages/flutter_element_ui/assets/icons/reading-lamp.svg": "98c5b9e32ffd719f6f73a4e68f059989",
"assets/packages/flutter_element_ui/assets/icons/caret-bottom.svg": "54b3f7882731d6d2f62782923e20832e",
"assets/packages/flutter_element_ui/assets/icons/comment.svg": "8c150a59d68d74e079413b458dba6df3",
"assets/packages/flutter_element_ui/assets/icons/search.svg": "fb18dba804f8622e93838e9803433adc",
"assets/packages/flutter_element_ui/assets/icons/cellphone.svg": "42ca1f238883dd6b516fc8825d060b2e",
"assets/packages/flutter_element_ui/assets/icons/odometer.svg": "85f9fb20e9b1ec13a3b37f41bba083b9",
"assets/packages/flutter_element_ui/assets/icons/data-board.svg": "c2cbf6a06f0d4608aef99cadb88274a6",
"assets/packages/flutter_element_ui/assets/icons/sold-out.svg": "2dcf460b59893dc9ee3680eb2f997c24",
"assets/packages/flutter_element_ui/assets/icons/folder-checked.svg": "fc45a865754bd48367f1ef13c28166f9",
"assets/packages/flutter_element_ui/assets/icons/files.svg": "5eab947a26297ca43fa9c24740e46bf7",
"assets/packages/flutter_element_ui/assets/icons/camera.svg": "761af5b8adc540122413f3b61120366b",
"assets/packages/flutter_element_ui/assets/icons/picture-rounded.svg": "b08603fe73d8366f9ccb24ac2ec09e88",
"assets/packages/flutter_element_ui/assets/icons/add-location.svg": "7d3052bbb2bd17c94b4dc55bdff9df87",
"assets/packages/flutter_element_ui/assets/icons/copy-document.svg": "3d8b3794bdf2c48f87ae2f2ff98b1612",
"assets/packages/flutter_element_ui/assets/icons/help-filled.svg": "e53de10220d383c8a07a76d97b1f87b8",
"assets/packages/flutter_element_ui/assets/icons/hide.svg": "ab29366a32dff147bbe3f7c69d1b3588",
"assets/packages/flutter_element_ui/assets/icons/cold-drink.svg": "fa6f216eb0b64a45f8eaa84f8cfa3905",
"assets/packages/flutter_element_ui/assets/icons/refresh-left.svg": "85eefb2f57b47be40a60878065d5fbe6",
"assets/packages/flutter_element_ui/assets/icons/arrow-right.svg": "086f5cc96c134971d52dc8ce74430371",
"assets/packages/flutter_element_ui/assets/icons/soccer.svg": "5da789d1b9ba3bca169635cdc573845c",
"assets/packages/flutter_element_ui/assets/icons/loading.svg": "64a6ff782fd051da9b57e508c8afce94",
"assets/packages/flutter_element_ui/assets/icons/service.svg": "9c8dc412bf89260204d6736a70869ee0",
"assets/packages/flutter_element_ui/assets/icons/cpu.svg": "a8bd8e7ca90e3a8e2e0361df08012c28",
"assets/packages/flutter_element_ui/assets/icons/document-copy.svg": "73957a02ce0fe543819d147f193641d6",
"assets/packages/flutter_element_ui/assets/icons/burger.svg": "244d1ca077dc0c80532a3176151b22b9",
"assets/packages/flutter_element_ui/assets/icons/caret-left.svg": "6467dc67f2fae910dad6295043ab46d0",
"assets/packages/flutter_element_ui/assets/icons/data-line.svg": "5d8f48772ff4531cfbacd803b0422b8c",
"assets/packages/flutter_element_ui/assets/icons/handbag.svg": "54d65e73a2bbe1cb55c8d4d7ac7989da",
"assets/packages/flutter_element_ui/assets/icons/food.svg": "980541f609e308f2a6007fea0d21d7ae",
"assets/packages/flutter_element_ui/assets/icons/position.svg": "6f197e5d42ca61a4fc16d8be2fa02c8a",
"assets/packages/flutter_element_ui/assets/icons/grape.svg": "73e551ab267013d6cc3af94130c456f9",
"assets/packages/flutter_element_ui/assets/icons/moon.svg": "9fc6d1ac811c30f29de1aeddfc565c7e",
"assets/packages/flutter_element_ui/assets/icons/document-checked.svg": "eee72846af5117fa154be923feeff6fe",
"assets/packages/flutter_element_ui/assets/icons/delete-filled.svg": "e0ba32ea7e43d7d804172aa579c7ac38",
"assets/packages/flutter_element_ui/assets/icons/place.svg": "641c20cc89d53f54f626f835da323afa",
"assets/packages/flutter_element_ui/assets/icons/wallet-filled.svg": "f4facdb66231f7f6a5d78432b95db40f",
"assets/packages/flutter_element_ui/assets/icons/user.svg": "b06920f4d17238bcf6bb0726a716709e",
"assets/packages/flutter_element_ui/assets/icons/edit.svg": "3907fdea1ddd0009718e03eb552f4855",
"assets/packages/flutter_element_ui/assets/icons/caret-top.svg": "4ba28b8642a2cb179c077e1db09c1c8f",
"assets/packages/flutter_element_ui/assets/icons/share.svg": "bd5b73211fa0831545087c6105301472",
"assets/packages/flutter_element_ui/assets/icons/remove.svg": "b36a160ac56bbeb6897a129960a36c60",
"assets/packages/flutter_element_ui/assets/icons/tools.svg": "86d4e31970cb5c4cca76a23312021530",
"assets/packages/flutter_element_ui/assets/icons/toilet-paper.svg": "08373d8c32623b8a8fba29672cf51a14",
"assets/packages/flutter_element_ui/assets/icons/monitor.svg": "5c96a805ba53d453a6aee486ba0cf68d",
"assets/packages/flutter_element_ui/assets/icons/minus.svg": "a7f8e8b686b3a29bd18fa3e0122b4778",
"assets/packages/flutter_element_ui/assets/icons/location.svg": "8cfa7aa2ee49518f7d22a4b9d4a51eaf",
"assets/packages/flutter_element_ui/assets/icons/collection-tag.svg": "8033c44de1b476446ffb06479711eec4",
"assets/packages/flutter_element_ui/assets/icons/eleme.svg": "acc3a7229bfbe311f0cc46a720903db0",
"assets/packages/flutter_element_ui/assets/icons/ice-cream-round.svg": "ed3b8b21c018e886e35c0fa7b9d83e1d",
"assets/packages/flutter_element_ui/assets/icons/mostly-cloudy.svg": "51927613d731a224fe8b58993951cb1e",
"assets/packages/flutter_element_ui/assets/icons/circle-close-filled.svg": "c793828b5b75a04f455ce6a391e7837d",
"assets/packages/flutter_element_ui/assets/icons/alarm-clock.svg": "d2a6537d156c41807b1cb05b474be74a",
"assets/packages/flutter_element_ui/assets/icons/present.svg": "b81a3917503f6423258987923ed69d53",
"assets/packages/flutter_element_ui/assets/icons/discount.svg": "5336daf10cedc6e0ffead8c3a04a492e",
"assets/packages/flutter_element_ui/assets/icons/set-up.svg": "02439bd677f9b929e09b9df0360b1619",
"assets/packages/flutter_element_ui/assets/icons/brush-filled.svg": "060a94e8e046a3666afc4f446fb5c3a3",
"assets/packages/flutter_element_ui/assets/icons/crop.svg": "85a91f09861e16c9fce41e4eded33383",
"assets/packages/flutter_element_ui/assets/icons/shopping-cart.svg": "3c12d1a53f7bbd8209d7361f7c5b1790",
"assets/packages/flutter_element_ui/assets/icons/watch.svg": "018914238741bb5e167e614b74e8080c",
"assets/packages/flutter_element_ui/assets/icons/sugar.svg": "cd851acd5e93bffcd619449ca8d75821",
"assets/packages/flutter_element_ui/assets/icons/grid.svg": "ebae78f263885f707417b2a843fd3103",
"assets/packages/flutter_element_ui/assets/icons/drizzling.svg": "03d356cf73eb5864846bc6c568ec4044",
"assets/packages/flutter_element_ui/assets/icons/checked.svg": "4cbcf9168237519a1c3f451e1b7760cb",
"assets/packages/flutter_element_ui/assets/icons/failed.svg": "23c7f8d804ffae7ae8f4e369c56d13e1",
"assets/packages/flutter_element_ui/assets/icons/close.svg": "9fd2cc7fb8baa2fedcdf1015fe2d6c7b",
"assets/packages/flutter_element_ui/assets/icons/d-arrow-left.svg": "23f5abff2a5fb3a5fcb5f91e7b7ad3b2",
"assets/packages/flutter_element_ui/assets/icons/dessert.svg": "c48c5fc98bb73a9cacbd523bc9f70a5d",
"assets/packages/flutter_element_ui/assets/icons/management.svg": "cf58b008854dcaa8baa44df45d1f7182",
"assets/packages/flutter_element_ui/assets/icons/trend-charts.svg": "946281b5a745836e5f244b6b0ddca4b2",
"assets/packages/flutter_element_ui/assets/icons/ticket.svg": "8b8285e1120fb23dc134e547af5c1596",
"assets/packages/flutter_element_ui/assets/icons/arrow-left.svg": "fc5a60df114851152087c4ccb8d2a9c2",
"assets/packages/flutter_element_ui/assets/icons/cloudy.svg": "7c94ff5f794108bbf53e69e988342f7b",
"assets/packages/flutter_element_ui/assets/icons/caret-right.svg": "9d7b332db84a7c0a06ba2ca71314690f",
"assets/packages/flutter_element_ui/assets/icons/d-caret.svg": "d6a9ba04d1f6cda9032a0a7aac12642f",
"assets/packages/flutter_element_ui/assets/icons/coin.svg": "c2ae5a022d99c63cbe6784a0532403db",
"assets/packages/flutter_element_ui/assets/icons/document-remove.svg": "015fb456b8db91375f6d21680c9a73cc",
"assets/packages/flutter_element_ui/assets/icons/connection.svg": "686a1e6d25f1c9ca5d3353dd3ebb206f",
"assets/packages/flutter_element_ui/assets/icons/delete.svg": "d4385ca0dcedb21fc6610d44f3a9d56c",
"assets/packages/flutter_element_ui/assets/icons/umbrella.svg": "9f9ab74c5817d6d17e50c08dca42ecec",
"assets/packages/flutter_element_ui/assets/icons/aim.svg": "1c130065cb31e5213572cbb7e2dd3c01",
"assets/packages/flutter_element_ui/assets/icons/promotion.svg": "f653678b441a99c79dfef891147de3e8",
"assets/packages/flutter_element_ui/assets/icons/chat-line-round.svg": "b550d6254b4f057832fc2cb84981f0e2",
"assets/packages/flutter_element_ui/assets/icons/folder-add.svg": "beabe8d0680bcdedcb141fc12031aefb",
"assets/packages/flutter_element_ui/assets/icons/mouse.svg": "cdf358779b56f6d53c01fcfbed30c0a4",
"assets/packages/flutter_element_ui/assets/icons/sort-up.svg": "b064ef186c8fafe57cdb4554a834c194",
"assets/packages/flutter_element_ui/assets/icons/semi-select.svg": "7b9955ea8deacc8b96e1e304a6cb6bb5",
"assets/packages/flutter_element_ui/assets/icons/arrow-up-bold.svg": "568746644c6c9fc549d713b8a959ca5a",
"assets/packages/flutter_element_ui/assets/icons/fries.svg": "00223101165367f07e9580f7e946bb2c",
"assets/packages/flutter_element_ui/assets/icons/picture-filled.svg": "f9bf192f4460234fe70e0dbe640a528f",
"assets/packages/flutter_element_ui/assets/icons/knife-fork.svg": "f6fe93984dbc773d2cd95d5b8fb74e95",
"assets/packages/flutter_element_ui/assets/icons/brush.svg": "1022130cae95180b678fcb4977811704",
"assets/packages/flutter_element_ui/assets/icons/memo.svg": "d64a2e9e1f6a701373e87d3dcf5d7b4a",
"assets/packages/flutter_element_ui/assets/icons/close-bold.svg": "a93ad945000a6e5761bb45ac5ae7da1f",
"assets/packages/flutter_element_ui/assets/icons/smoking.svg": "b16c412e4412f54412911fe8e9289150",
"assets/packages/flutter_element_ui/assets/icons/fork-spoon.svg": "2c015df947f9c9aeacd908831740a485",
"assets/packages/flutter_element_ui/assets/icons/ship.svg": "4d739d98f915f9b7cc2561b056891950",
"assets/packages/flutter_element_ui/assets/icons/orange.svg": "0b2de72c25edae8a6eef57b69e166115",
"assets/packages/flutter_element_ui/assets/icons/edit-pen.svg": "2397bed6f5b3d244f61405ab71ce1f72",
"assets/packages/flutter_element_ui/assets/icons/chat-square.svg": "b5cd19c278b0a8bd14c936806183ccbc",
"assets/packages/flutter_element_ui/assets/icons/ice-cream-square.svg": "3d3b3e467ad630c1f383f85ea9c2efcf",
"assets/packages/flutter_element_ui/assets/icons/ice-tea.svg": "6477a2fad48a5055d42fbf33c1915f9d",
"assets/packages/flutter_element_ui/assets/icons/cherry.svg": "f9ea5a65e5c6190d132c9a80e027ac07",
"assets/packages/flutter_element_ui/assets/icons/chat-dot-round.svg": "bc105a88e3b4afec32bb7f0db7021d37",
"assets/packages/flutter_element_ui/assets/icons/trophy.svg": "297ef1b03de09a9d5a75da7e9f522d78",
"assets/packages/flutter_element_ui/assets/icons/platform.svg": "96b12f28a6e9a46b02f752b1807e2281",
"assets/packages/flutter_element_ui/assets/icons/suitcase-line.svg": "adf006700814c11face02fc4575cbf3b",
"assets/packages/flutter_element_ui/assets/icons/paperclip.svg": "ae4510f9c327d8a76a2a1a843bda009c",
"assets/packages/flutter_element_ui/assets/icons/mug.svg": "bc78b89b3c2f28514f1e65b9f4e66f8a",
"assets/packages/flutter_element_ui/assets/icons/sort.svg": "075a67da0961eda1e1a22648c71a3e20",
"assets/packages/flutter_element_ui/assets/icons/takeaway-box.svg": "51ae6539ae2aad250a50f75e68b66b48",
"assets/packages/flutter_element_ui/assets/icons/folder.svg": "ea31cc36c975787d77149f2362e690bf",
"assets/packages/flutter_element_ui/assets/icons/goods.svg": "0b4542b263109ea7835f1dd98108a1bc",
"assets/packages/flutter_element_ui/assets/icons/football.svg": "9de93a5473df87b3ad6e51ff82f12475",
"assets/packages/flutter_element_ui/assets/icons/setting.svg": "31960fb50bbf30793ebd0ce504050aa4",
"assets/packages/flutter_element_ui/assets/icons/coffee.svg": "105c5391830b2e279fc1841c48302ed6",
"assets/packages/flutter_element_ui/assets/icons/folder-opened.svg": "f756d1becee84fe1b129ab10377db187",
"assets/packages/flutter_element_ui/assets/icons/rank.svg": "c9afc271fdc376ff6f252d3e2779e4e2",
"assets/packages/flutter_element_ui/assets/icons/coffee-cup.svg": "a3f77d16ee7a6c80182a684eaafa47bc",
"assets/packages/flutter_element_ui/assets/icons/quartz-watch.svg": "c115e6017e7731ee882fd75f6b574ef8",
"assets/packages/flutter_element_ui/assets/icons/switch-button.svg": "67b1ba548048a5f2b4e0681e804a1e34",
"assets/packages/flutter_element_ui/assets/icons/operation.svg": "bf029df65dc4c4ea703488bb930737ea",
"assets/packages/flutter_element_ui/assets/icons/download.svg": "5f7c2b442b5dd8cc982cc9d55f07fe30",
"assets/packages/flutter_element_ui/assets/icons/film.svg": "17f34445d72a694ec59a9bb656e334dc",
"assets/packages/flutter_element_ui/assets/icons/phone-filled.svg": "15b36b0b7aeaae5891db49d51e714459",
"assets/packages/flutter_element_ui/assets/icons/sell.svg": "5612a1fb8d16b3c5daae24d3ca1395f3",
"assets/packages/flutter_element_ui/assets/icons/zoom-in.svg": "fec0944767c4077b610eede7f3d9ab7f",
"assets/packages/flutter_element_ui/assets/icons/camera-filled.svg": "caff4971bb0bcf476030dc55fe6b6102",
"assets/packages/flutter_element_ui/assets/icons/magic-stick.svg": "ab36ba32b65105c3f7d3c327ec49789b",
"assets/packages/flutter_element_ui/assets/icons/circle-check-filled.svg": "911b8cd29d3f5e05336baf0ee66e99f2",
"assets/packages/flutter_element_ui/assets/icons/star.svg": "11c8934b11d5e4ab27a27b986f1116d8",
"assets/packages/flutter_element_ui/assets/icons/picture.svg": "3b2473f7ba906e6c71dfafb1976e3ff4",
"assets/packages/flutter_element_ui/assets/icons/school.svg": "489e35c4c2ef4d776b5fd308f36ea774",
"assets/packages/flutter_element_ui/assets/icons/map-location.svg": "bca5f6636359ad63ec5172f053b53e51",
"assets/packages/flutter_element_ui/assets/icons/hot-water.svg": "e71208e88ec7611c116541dc73838aad",
"assets/packages/flutter_element_ui/assets/icons/upload-filled.svg": "993e3c871099240e183705efb2102402",
"assets/packages/flutter_element_ui/assets/icons/shopping-cart-full.svg": "589dfea1d54ff2fd3195c74e8cd159fc",
"assets/packages/flutter_element_ui/assets/icons/data-analysis.svg": "2054f7d71bae707485630ba809e84dc7",
"assets/packages/flutter_element_ui/assets/icons/circle-check.svg": "6a34213c305b370ac8141161c853c12e",
"assets/packages/flutter_element_ui/assets/icons/sunset.svg": "a4353c4617363d3df2afcd32ec8dce8a",
"assets/packages/flutter_element_ui/assets/icons/bottom-right.svg": "a509892e7199867e616fbe5a059444dc",
"assets/packages/flutter_element_ui/assets/icons/full-screen.svg": "b2ef94db243d9e413591c72262dd92af",
"assets/packages/flutter_element_ui/assets/icons/sunrise.svg": "3dc96d71c6f45b2be306eb06df1ad2f6",
"assets/packages/flutter_element_ui/assets/icons/collection.svg": "82a3f80446b47266f4f04a183ad2cedf",
"assets/packages/flutter_element_ui/assets/icons/message.svg": "18372be5f96c4164a0da4d1f2d5f56b9",
"assets/packages/flutter_element_ui/assets/icons/magnet.svg": "8fa6f5bbbf6a149e11c8165cc0e8938a",
"assets/packages/flutter_element_ui/assets/icons/circle-close.svg": "63a2bf3252f8999af7be5ff6c83d0064",
"assets/packages/flutter_element_ui/assets/icons/lock.svg": "0f96c13be14407c658ea5aab24d8e1e7",
"assets/packages/flutter_element_ui/assets/icons/reading.svg": "8c09cfa242719e35b093fc771db31c66",
"assets/packages/flutter_element_ui/assets/icons/folder-delete.svg": "21de079b7876d79483ace6d12ae3ae97",
"assets/packages/flutter_element_ui/assets/icons/chicken.svg": "ebdf0cc806f453209f464c4bd4a77550",
"assets/packages/flutter_element_ui/assets/icons/right.svg": "03a08bf724ceefb5c4588bddd592e35f",
"assets/packages/flutter_element_ui/assets/icons/pointer.svg": "7856b265d2d984126e8ea506eb68f7ab",
"assets/packages/flutter_element_ui/assets/icons/shop.svg": "7456a7c8e4b851d96efb241c9987f1e5",
"assets/packages/flutter_element_ui/assets/icons/warn-triangle-filled.svg": "8484ec2a0a7891f3de373ed022d16228",
"assets/packages/flutter_element_ui/assets/icons/remove-filled.svg": "3924d0c22112769643132d3feb43db54",
"assets/packages/flutter_element_ui/assets/icons/goblet.svg": "45be76fb26a612a5bad9fd9da895d4d2",
"assets/packages/flutter_element_ui/assets/icons/switch.svg": "416d940aa77372633535a6ba4e7f84b0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "88ee379fe6e12018f694d5c92ab80e70",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/NOTICES": "39e5a06f79932cc162a195241367d804",
"assets/AssetManifest.bin": "10801fc1c7e1e47c8dfcb0410d0d6ea7",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"main.dart.wasm",
"main.dart.mjs",
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
