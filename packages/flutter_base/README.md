# flutter基础库

- 生成app图标

> flutter pub run flutter_launcher_icons:main

- 打包apk（android，不要使用，安卓需要区分环境，执行最下面的命令）

> flutter build apk
> flutter build apk --target-platform android-arm64 --no-tree-shake-icons

- 打包ipa（ios -> app-store包，上架应用商店）

> flutter build ipa --release

- 打包ipa（ios -> ad-hoc包，给测试机型使用）

> flutter build ipa --release --export-method=ad-hoc

- 安装打包好的app

> flutter install

- 在谷歌浏览器上运行

> flutter run -d chrome --web-renderer html --flavor prod -t lib/main_prod.dart
> flutter run -d chrome --web-renderer canvaskit --flavor prod -t lib/main_prod.dart

- 打包和安装指定环境的app（仅限android）

> flutter build apk --flavor dev -t lib/main_dev.dart --target-platform android-arm64
> flutter install --use-application-binary build/app/outputs/flutter-apk/app-dev-release.apk

> flutter build apk --flavor prod -t lib/main_prod.dart --target-platform android-arm64
> --no-tree-shake-icons
> flutter install --use-application-binary build/app/outputs/flutter-apk/app-prod-release.apk

- 打包web

> flutter build web
> flutter build web --web-renderer html --pwa-strategy none
> flutter build web --web-renderer canvaskit --pwa-strategy none
> flutter build web --wasm --pwa-strategy none
> dhttpd --path build/web/

- 运行wasm
- cd build/web
- dhttpd '--headers=Cross-Origin-Embedder-Policy=credentialless;Cross-Origin-Opener-Policy=same-origin'

- 运行代码生成器

> flutter pub run build_runner build

- 添加指定平台

> flutter create --platforms=windows,macos,linux,web

- 创建包

> flutter create --template=package

- android minsdk>23需要手动在android下设置以下属性才能压缩安装包

```
packagingOptions {
        jniLibs {
            useLegacyPackaging = true
        }
    }
```

- 发布包到pub商店

> flutter pub publish --server=https://pub.dartlang.org