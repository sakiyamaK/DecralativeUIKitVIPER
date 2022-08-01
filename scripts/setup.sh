#!/bin/sh

cd `git rev-parse --show-toplevel`

#pipで管理しているパッケージのインストール
pip install -I strgen

#pipで管理しているパッケージの実行
strgen --config ./DecralativeUIKitVIPER/strgen/resource/setting.yml

#mintで管理しているパッケージのインストール
mint bootstrap

#mintで管理してるパッケージの実行
mint run xcodegen xcodegen generate
mint run realm/swiftlint swiftlint --fix --format

#Gemfileで管理しているパッケージのインストール
bundle install

#バージョン固定されたpodでinstall
bundle exec pod install
if [ "$?" -ne 0 ]; then
  echo "retry 'pod install' using '--repo-update'"
  bundle exec pod install --repo-update
fi

#podで管理しているパッケージの実行
./Pods/SwiftGen/bin/swiftgen config lint
./Pods/SwiftGen/bin/swiftgen config run