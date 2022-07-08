#!/usr/bin/env bash

if command -v create-dmg > /dev/null; then
  echo "building dmg"
else
    echo "create-dmg command has not found"
    echo "please install https://github.com/create-dmg/create-dmg"
    exit 1
fi
flutter build macos
rm -rf Release
rm *.dmg
mkdir Release
cp -r build/macos/Build/Products/Release/oplin.app Release/Oplin.app
create-dmg \
  --volname "Oplin Installer" \
  --volicon "snap/gui/oplin.png" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "Oplin.app" 200 190 \
  --hide-extension "Oplin.app" \
  --app-drop-link 600 185 \
  "Oplin-Installer.dmg" \
  "Release/"