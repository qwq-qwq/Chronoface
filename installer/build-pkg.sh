#!/bin/bash
# Сборка Chronoface installer .pkg
#
# Запуск из корня проекта:
#   bash installer/build-pkg.sh [version]
#
# По умолчанию version=1.0. Результат: dist/Chronoface-<version>.pkg
#
# Требования: pkgbuild, productbuild (входят в macOS).
# Без Developer ID Installer cert pkg будет ad-hoc signed - macOS Gatekeeper
# покажет warning при установке (нужно правый клик → Open). Для distribution
# без warnings нужен Apple Developer Program и подпись через --sign.

set -e

VERSION="${1:-1.0}"
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
INSTALLER_DIR="$ROOT_DIR/installer"
APP_PATH="${APP_PATH:-$ROOT_DIR/Chronoface/build2/Build/Products/Debug/Chronoface.app}"
SAVER_PATH="${SAVER_PATH:-$ROOT_DIR/Chronoface/build/Build/Products/Debug/Chronoface.saver}"
DIST_DIR="$ROOT_DIR/dist"
PAYLOAD_DIR="$DIST_DIR/payload-$$"
SCRATCH_PKG="$DIST_DIR/Chronoface.pkg"
FINAL_PKG="$DIST_DIR/Chronoface-$VERSION.pkg"

if [ ! -d "$APP_PATH" ]; then
  echo "ERROR: $APP_PATH не найден."
  echo "Сначала собери: cd Chronoface && xcodebuild -project Chronoface.xcodeproj -scheme ChronofaceApp -configuration Debug -derivedDataPath ./build build"
  exit 1
fi

if [ ! -d "$SAVER_PATH" ]; then
  echo "WARNING: $SAVER_PATH не найден - legacy .saver не будет включён в PKG."
  echo "Чтобы собрать: cd Chronoface && xcodebuild -project Chronoface.xcodeproj -scheme Chronoface -configuration Debug -derivedDataPath ./build build"
fi

mkdir -p "$DIST_DIR"
mkdir -p "$PAYLOAD_DIR/Applications"
mkdir -p "$PAYLOAD_DIR/Library/Screen Savers"

echo "→ Копирую Chronoface.app в payload (через ditto - без AppleDouble мусора)..."
ditto "$APP_PATH" "$PAYLOAD_DIR/Applications/Chronoface.app"
xattr -cr "$PAYLOAD_DIR/Applications/Chronoface.app"

if [ -d "$SAVER_PATH" ]; then
  echo "→ Копирую Chronoface.saver в payload (для macOS 13 fallback)..."
  ditto "$SAVER_PATH" "$PAYLOAD_DIR/Library/Screen Savers/Chronoface.saver"
  xattr -cr "$PAYLOAD_DIR/Library/Screen Savers/Chronoface.saver"
fi

find "$PAYLOAD_DIR" -name "._*" -delete 2>/dev/null || true
find "$PAYLOAD_DIR" -name ".DS_Store" -delete 2>/dev/null || true

echo "→ Генерирую component.plist (BundleIsRelocatable=false чтобы Installer не перенаправил в build/)..."
COMPONENT_PLIST="$DIST_DIR/component.plist"
pkgbuild --analyze --root "$PAYLOAD_DIR" "$COMPONENT_PLIST" >/dev/null
# Apple's Installer по умолчанию "relocate" bundle на основе LaunchServices DB.
# Это значит если уже есть Chronoface.app в build/Debug/, pkg обновит ЕГО, а не
# поставит в /Applications/. Выключаем relocation для всех bundle с этим ключом.
COUNT=$(/usr/libexec/PlistBuddy -c "Print" "$COMPONENT_PLIST" | grep -c "Dict {" || echo 0)
for i in $(seq 0 $((COUNT - 1))); do
    /usr/libexec/PlistBuddy -c "Set :$i:BundleIsRelocatable false" "$COMPONENT_PLIST" 2>/dev/null || true
done

echo "→ Собираю component package..."
chmod +x "$INSTALLER_DIR/scripts/postinstall"
pkgbuild \
  --root "$PAYLOAD_DIR" \
  --component-plist "$COMPONENT_PLIST" \
  --identifier "app.perek.rest.ChronofaceApp" \
  --version "$VERSION" \
  --install-location "/" \
  --scripts "$INSTALLER_DIR/scripts" \
  --ownership preserve-other \
  "$SCRATCH_PKG"
rm -f "$COMPONENT_PLIST"

echo "→ Собираю distribution package..."
productbuild \
  --distribution "$INSTALLER_DIR/distribution.xml" \
  --resources "$INSTALLER_DIR" \
  --package-path "$DIST_DIR" \
  "$FINAL_PKG"

echo "→ Кладу uninstall.sh рядом с pkg..."
cp "$INSTALLER_DIR/uninstall.sh" "$DIST_DIR/uninstall.sh"
chmod +x "$DIST_DIR/uninstall.sh"

rm -rf "$PAYLOAD_DIR" "$SCRATCH_PKG"

# Component package productbuild оставляет "Chronoface.pkg" в DIST если не подчищать
rm -f "$DIST_DIR/Chronoface.pkg"

echo ""
echo "✓ Готово: $FINAL_PKG"
echo "✓ Uninstall: $DIST_DIR/uninstall.sh"
echo ""
echo "Установка: открой $FINAL_PKG двойным кликом (или 'sudo installer -pkg ... -target /')"
echo "Удаление:  bash $DIST_DIR/uninstall.sh"