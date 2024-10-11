flutter --version
flutter pub get
# shellcheck disable=SC2164
cd ./packages/element_docs
flutter pub upgrade
flutter build web --web-renderer=html --base-href /flutter_element_ui/
#flutter build web --web-renderer=canvaskit --pwa-strategy none --base-href /flutter_element_ui/
