#!/bin/bash
# Chronoface uninstaller. Запуск:
#   bash uninstall.sh
#
# Удаляет:
#   - /Applications/Chronoface.app
#   - shared settings /Users/Shared/Chronoface/
#   - sandbox containers и кеши
#   - pluginkit registration
#   - legacy .saver (если был установлен предыдущей версией)

set +e

echo "Chronoface uninstaller"
echo "======================"
echo ""

read -p "Удалить Chronoface и все его данные? (y/N) " yn
case $yn in
  [Yy]*) ;;
  *) echo "Отменено."; exit 0 ;;
esac

echo "→ Закрываю процессы..."
pkill -f "Chronoface" 2>/dev/null
pkill -f "WallpaperAgent" 2>/dev/null
pkill -f "legacyScreenSaver" 2>/dev/null
osascript -e 'tell application "System Settings" to quit' 2>/dev/null
sleep 1

echo "→ Снимаю extension с регистрации..."
pluginkit -e ignore -i app.perek.rest.ChronofaceApp.ChronofaceExtension 2>/dev/null
if [ -d "/Applications/Chronoface.app/Contents/PlugIns/ChronofaceExtension.appex" ]; then
  pluginkit -r "/Applications/Chronoface.app/Contents/PlugIns/ChronofaceExtension.appex" 2>/dev/null
fi

echo "→ Удаляю /Applications/Chronoface.app..."
if [ -w /Applications ]; then
  rm -rf /Applications/Chronoface.app
else
  sudo rm -rf /Applications/Chronoface.app
fi

echo "→ Удаляю legacy .saver если есть..."
if [ -d "/Library/Screen Savers/Chronoface.saver" ]; then
  sudo rm -rf "/Library/Screen Savers/Chronoface.saver"
fi

echo "→ Удаляю shared данные..."
rm -rf "/Users/Shared/Chronoface" 2>/dev/null

echo "→ Удаляю кеши, preferences, scripts..."
rm -rf ~/Library/Caches/app.perek.rest.ChronofaceApp 2>/dev/null
rm -rf ~/Library/Caches/com.screensaver.Chronoface.App 2>/dev/null
rm -rf ~/Library/Preferences/app.perek.rest.ChronofaceApp.plist 2>/dev/null
rm -rf ~/Library/Preferences/com.screensaver.Chronoface.plist 2>/dev/null
rm -rf ~/Library/HTTPStorages/com.screensaver.Chronoface.App 2>/dev/null
rm -rf ~/Library/"Application Scripts"/app.perek.rest.ChronofaceApp* 2>/dev/null
rm -rf ~/Library/"Application Scripts"/com.screensaver.Chronoface* 2>/dev/null

echo "→ Sandbox containers (требует подтверждения в Finder если не получится через rm)..."
rm -rf ~/Library/Containers/app.perek.rest.ChronofaceApp* 2>/dev/null
rm -rf ~/Library/Containers/com.screensaver.Chronoface* 2>/dev/null

echo "→ Удаляю PKG receipt..."
sudo pkgutil --forget app.perek.rest.ChronofaceApp 2>/dev/null

echo "→ Перезапускаю WallpaperAgent..."
killall WallpaperAgent posterserviced 2>/dev/null

echo ""
echo "Готово. Если в ~/Library/Containers/ остались папки app.perek.rest.ChronofaceApp* -"
echo "удалите их вручную через Finder (Cmd+Backspace, sandbox защищает от rm -rf)."