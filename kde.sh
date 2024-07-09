#!/usr/bin/bash
# Переключение смены расскладки на глобальную
kwriteconfig5 --file kxkbrc --group Layout --key SwitchMode --type string Global
# Включение NumLock в системе
kwriteconfig5 --file kcminputrc --group Keyboard --key NumLock --type int 0

# Отключение действий по нажатию на край экрана (При тестировании выяснилось что не работает)
kwriteconfig5 --file kwinrc --group ElectricBorders --key TopLeft --delete
#kwriteconfig5 --file kwinrc --group \$Version --key update_info --type string 'kwin.upd:replace-scalein-with-scale,kwin.upd:port-minimizeanimation-effect-to-js,kwin.upd:port-sc>'
#kwriteconfig5 --file systemsettingsrc --group MainWindow --key RestorePositionForNextInstance --type bool false


# Убираем лишнее с рабочего стола
rm -rf ~/Рабочий\ стол/Документация
rm -rf ~/Рабочий\ стол/mos-appstore.desktop
rm -rf ~/Рабочий\ стол/chromium-browser.desktop

# Установка ПО
package_name=flameshot
if dnf list installed | grep $package_name > /dev/null; then
  echo "flameshot установлен"
else
  echo "flameshot не установлен, дальнейшее выполнение скрипта не возможно. Устновите flameshot с помощью команды: dnf install flameshot"
  exit 1
fi

# Код ниже назначает flameshot программой, вызываемой при нажатии клавиши PrintScreen
# Комбинация начнет работать после перезагрузки компьютера

# Сперва удаляем горячие клавиши для spectacle
kwriteconfig5 --file kglobalshortcutsrc --group org.kde.spectacle.desktop --key ActiveWindowScreenShot --delete
kwriteconfig5 --file kglobalshortcutsrc --group org.kde.spectacle.desktop --key CurrentMonitorScreenShot --delete
kwriteconfig5 --file kglobalshortcutsrc --group org.kde.spectacle.desktop --key FullScreenScreenShot --delete
kwriteconfig5 --file kglobalshortcutsrc --group org.kde.spectacle.desktop --key OpenWithoutScreenshot --delete
kwriteconfig5 --file kglobalshortcutsrc --group org.kde.spectacle.desktop --key RectangularRegionScreenShot --delete
kwriteconfig5 --file kglobalshortcutsrc --group org.kde.spectacle.desktop --key WindowUnderCursorScreenShot --delete
kwriteconfig5 --file kglobalshortcutsrc --group org.kde.spectacle.desktop --key _k_friendly_name --delete
kwriteconfig5 --file kglobalshortcutsrc --group org.kde.spectacle.desktop --key _launch --delete

# Теперь назначаем для flameshot
kwriteconfig5 --file kglobalshortcutsrc --group org.flameshot.Flameshot.desktop --key Capture --type string Print,none,Сделать\ скриншот
kwriteconfig5 --file kglobalshortcutsrc --group org.flameshot.Flameshot.desktop --key Configure --type string none,none,Настройки
kwriteconfig5 --file kglobalshortcutsrc --group org.flameshot.Flameshot.desktop --key Launcher --type string none,none,Open\ launcher
kwriteconfig5 --file kglobalshortcutsrc --group org.flameshot.Flameshot.desktop --key _k_friendly_name --type string Flameshot
kwriteconfig5 --file kglobalshortcutsrc --group org.flameshot.Flameshot.desktop --key _launch --type string none,none,Flameshot
