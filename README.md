# DecralativeUIKitVIPER

# setup

## 事前に1度だけやること

### Homebrewのインストール

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### mintのインストール

```
brew install mint
```

### rbenvとRubyのインストール

```
brew install rbenv
```

上記だけではうまくいかない可能性あり、以下を参考にする

https://qiita.com/hujuu/items/3d600f2b2384c145ad12
 
 ```
$ rbenv install -list
※インストールしたいバージョンが表示されていることを確認

$ rbenv install ”インストールしたいバージョン”
 ```

 基本的には最新バージョンを取ればよい


### pyenvとpytyonのインストール

```
brew install pyenv
```

上記だけではうまくいかない可能性あり、以下を参考にする

https://zenn.dev/kenghaya/articles/9f07914156fab5

 ```
$ pyenv install -list
※インストールしたいバージョンが表示されていることを確認

$ pyenv install ”インストールしたいバージョン”
 ```

 基本的には最新バージョンを取ればよい

## xcodeprojの作成

ファイル、ライブラリ、リソース、ローカライズが増える度に実行する

```
make
```

MakeFile内のsetupが動き`cocoapods`,`mint`, `pip`で管理しているパッケージのインストールとパッケージの実行をして、最後に`DecralativeUIKitVIPER.xcworkspace`が起動する

## 新規画面の作成

```
make component name=<component name>
```

例
```
make component name=Hoge
```
とすると`source/VIPER/`内に以下のVIPER構成のファイル群ができる

- `Entity/HogeEntity.swift`
- `Interactor/HogeInteractor.swift`
- `Presenter/HogePresenter.swift`
- `Router/HogeRouter.swift`
- `View/HogeViewController.swift`

最後に`make`を実行してプロジェクトファイルを更新する

```
make
```

## 初期化

```
make clean
```

MakeFile内のcleanが動き`make`で増えたファイルが消える


## リソース追加

1,2,3のどれでもいい

1. Assets.xcassetsに追加後に `make`
2. Assets.xcassetsに追加後に `make swiftgen` (最も早いはず)
3. Assets.xcassetsに追加後にビルドするとAssets-Constants.swiftが更新される


## 翻訳の追加

`DecralativeUIKitVIPER/strgen/resource/localize.csv`

に追記したあと `make`


## 申請
以下のコマンドを実行
`make release`


# VIPERアーキテクチャ

- `View`
  - 画面構成をする
  - UIKitでいうUIViewController
  - UIViewを構築してUIViewのアクションを`Presenter`に伝える
  - UIKitに依存した処理しか書かない
  - UIViewと自身以外のUIViewControllerと`Presenter`以外のパラメータを持たない
- `Interactor`
  - API処理やロジックを担当してデータを持つ
  - 初期化時のパラメータとして`Dependency`をもらうことでデフォルト値が決まる
- `Presenter` 
  - その他のコンポーネントの中継役
  - データを持たない
  - ロジックを書かない
- `Router`
  - 画面遷移と全体のコンポーネントの依存関係の設定
- `Entitiy`
  - その画面で利用するデータ型
  - 例えばあちこちで使う`User`とかも`typealias XXUserEntity = User`とか名前をつけてその画面のEntityとする

Interactorは複数でも良いし一つでも良い

MVVMで肥大化していたViewModelを複数のIntearctorに分割してPresenterで中継するイメージ

```
          Router
              |
View - Presenter --- MainInteractor 
                  |- GetAPIInteractor
                  |- PostAPIInteractor

Interactorで生成されたEntityが他のコンポーネントに渡されていく
```


各コンポーネントは直接繋がずProtocolで繋ぐ

Protocolの名前とClassの名前の対応表

|Class| Protocol|
|:----|:----|
|XXViewController| XXView|
|XXPresenter| XXPresentation|
|XXInreractor| XXUsecase|
|XXRouter| XXWireframe|
|XXEntitiy| --|



# データ連携
VIPERのコンポーネント間は`RxSwift`を用いてリアクティブにやっている

さらに`@RxPublished` というPropertyWrapperを用意して普通のパラメータのように渡せる仕組みにしている

初期値をもつのは `Interactor` だけなので、他のコンポーネントはnilにしている

```swift
@RxPublished var hoge: Int?

//$hogeとすることでObservableとなる
$hoge.filterNil().bind(Binder(self) {_self, value in
  //hogeに値を代入する度にここが呼ばれる
}).disposeBag(rx.disposeBag)

hoge = 1
hoge = 2
hoge = 3
```

# 画面構成

## DecralativeUIKit
UIKitのままSwiftUIのように宣言的に書けるライブラリを利用している

https://github.com/sakiyamaK/DeclarativeUIKit

`UILabel`や`UIButton`といったUIKit標準のクラスやメソッドの呼び出しは変わらず、レイアウトだけ宣言的に書ける

```swift
final class HogeViewController: UIViewController {
  override func loadView() {
    super.loadView()
    // UIScrollViewの中にUIStackViewを置いて
    // UIView, UIButton, UILabelを並べる
    UIScrollView.vertical {
      UIStackView.vertical {
        UIView().height(200)
        UIButton().height(200)
        UILabel().height(200)
      }
    }
  }
}

```

日本語ドキュメントの各sampleを見ると分かりやすい

https://github.com/sakiyamaK/DeclarativeUIKit/blob/develop/Documentation/ja/index.md



## ホットリロード
シミュレータ限定だがソースコードの変更を即時反映するホットリロードの仕組みを入れている

githubから取ってもmac app storeのどちらから取ってもいい

github

https://github.com/johnno1962/InjectionIII

mac app store

https://apps.apple.com/app/injectioniii/id1380446739?mt=12


参考リンク

情報が古めだったりSwiftUIで設定していたりするが基本は同じ

https://qiita.com/KoichiroEto/items/5cb149a6e5d74bbdd66c

https://zenn.dev/kalupas226/articles/ee015363625354

# API連携

Moya + Alamofire

あとで追記する

# 利用するパッケージ管理ツール

<img src="https://i.gyazo.com/684c6ba6dd7eed821505fe5360c166df.png" />

## Homebrew

コマンドラインツールのパッケージ管理ツール

https://brew.sh/index_ja.html

## CocoaPods
iOSで使うパッケージの管理ツール

Ruby製で作られたパッケージをインストールできる

CocoaPodsのバージョン自体はGemfileで管理している

https://cocoapods.org/

## Gem

コマンドラインツールのパッケージ管理ツール

Rubyで標準に備わっている

Rubyのバージョン自体はrbenvで管理することを推奨する

各自の環境で用意する

管理ファイルは `Gemfile`

## Mint

コマンドラインツールのパッケージ管理ツール

Swift製で作られたパッケージをインストールできる

Mint自体はHomebrewで管理している

https://qiita.com/uhooi/items/6a41a623b13f6ef4ddf0#mint%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB

管理ファイルは `Mintfile`

## pip

コマンドラインツールのパッケージ管理ツール

Python製で作られたパッケージをインストールできる

Pytyonで標準に備わっている

Pytyonのバージョン自体はpyenvで管理することを推奨する

各自の環境で用意する

管理ファイルはなく`scripts/setup.sh`で直接必要なパッケージをインストールしている


## rbenv

Ruby言語自体のバージョン管理をするツール

Gemを使うためrbenvでRubyのバージョンを揃えた方がいい

https://qiita.com/hujuu/items/3d600f2b2384c145ad12

## pyenv

Python言語自体のバージョン管理をするツール

pipを使うためpyenvでPythonのバージョンを揃えた方がいい

https://zenn.dev/kenghaya/articles/9f07914156fab5

# その他のツール

## xcodegen

`xcodeproj`ファイルを生成する

管理ファイルは`project.yml`

## make

makeコマンド(macデフォルトである？)

`make`と指定するだけで良いのでシェルのように最初どのシェルを叩けばいいか分からなくなることがない

管理ファイルは `Makefile`

細かい設定がしづらいものは `scripts/`の中の`XX.sh`でやっている


## Pui

新規画面の作成時のボイラープレート生成ツール

https://github.com/sakiyamaK/Pui

管理ファイルは `Pui.yml`

テンプレートファイルは`templates/PuiTemplate/ios/VIPER/`

# SwiftGen

リソース管理ツール

管理ファイルは `swiftgen.yml`


# strgen

翻訳ファイル管理ツール

翻訳ファイルは`DecralativeUIKitVIPER/strgen/resource/localize.csv`

管理ファイルは `DecralativeUIKitVIPER/strgen/resource/setting.yml`


# fastlane

CI/CDツール

管理ファイルは `fastlane/` (20220801現在、まだ設定していないためこのフォルダはない)

