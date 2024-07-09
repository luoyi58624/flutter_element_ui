flutter --version
flutter pub get
# shellcheck disable=SC2164
cd ./example
#flutter build web --wasm --pwa-strategy none --base-href /flutter_element_ui/
flutter build web --web-renderer=html --base-href /flutter_element_ui/
#flutter build web --web-renderer=canvaskit --pwa-strategy none --base-href /flutter_element_ui/
