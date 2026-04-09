[English](README.md)

# AutoLayoutUtilities

Appleプラットフォーム (iOS / macOS) のAuto Layoutを簡潔に記述するための軽量Swiftライブラリです。作者が個人的に利用していたものをついでに公開しました。

## 特徴

- AppKitとUIKitをプラットフォーム型エイリアスで統一したAPI
- `@discardableResult`によるチェイン可能な制約生成
- `LayoutProxy`による簡潔なアンカーアクセス (`view.layout.top`, `view.layout.width` など)
- 四辺・サイズ・中央揃えの制約を一括生成するヘルパー
- 制約配列の一括`activate()` / `deactivate()`
- identifierによる制約の管理・削除
- `addSubview(_:constraints:)` — サブビュー追加と制約適用を1回の呼び出しで実行
    - `translatesAutoresizingMaskIntoConstraints = false`省略可能
- 比較演算子 (equal, greaterThanOrEqual, lessThanOrEqual) とシステムスペーシングに対応

## 要件

- Swift 6.0+
- iOS 18.0+ / macOS 15.0+

## インストール

### Swift Package Manager

`Package.swift`に以下を追加してください:

```swift
dependencies: [
    .package(url: "https://github.com/usagimaru/AutoLayoutUtilities.git", from: "1.0.0"),
]
```

Xcodeの場合: **File > Add Package Dependencies…** からリポジトリURLを入力してください。

## 使い方

### `addSubview()`と同時に四辺を親ビューにピン留め

```swift
container.addSubview(childView) { subview, parentView in
    subview.layout.edgeConstraints(to: parentView.safeAreaLayoutGuide, constant: 20)
}
```

### `addSubview()`と同時にXY中央配置・縦横固定サイズ化

```swift
container.addSubview(box) { subview, parentView in
    subview.layout.centerConstraints(to: parentView) +
    subview.layout.sizeConstraints(to: 80)
}
```

### アンカーの個別指定

```swift
[
    viewA.layout.top.constraint(to: viewB.layout.bottom, constant: 20),
    viewA.layout.centerX.constraint(to: viewB.layout.centerX),
    viewA.layout.width.constraint(to: viewB.layout.width),
    viewA.layout.height.constraint(to: 40),
].activate()
```

### システムスペーシング

```swift
[
    label.layout.top.systemConstraint(to: parentView.layout.top),
    label.layout.leading.systemConstraint(to: parentView.layout.leading),
].activate()
```

### swapItems

bottomやtrailingのconstant値がマイナスに反転する場合には、`swapItems`引数で制約先のアイテムを簡単に入れ替えられます。`edgeConstraints()`メソッドではbottom/trailingのswapItemsが自動的に適用されます。

```swift
// bottom/trailingではconstant値の方向が逆転するため、swapItemsで制約アイテムを入れ替える
[
    subview.layout.top.constraint(to: parentView.layout.top, constant: 20),
    subview.layout.leading.constraint(to: parentView.layout.leading, constant: 20),
    subview.layout.bottom.constraint(to: parentView.layout.bottom, constant: 20, swapItems: true), // <---
    subview.layout.trailing.constraint(to: parentView.layout.trailing, constant: 20, swapItems: true), // <---
].activate()
```

## API概要

### アンカー拡張

| 型 | メソッド | 説明 |
|------|--------|-------------|
| `NSLayoutXAxisAnchor` | `constraint(to:operator:constant:priority:swapItems:)` | 水平方向のアンカー制約 |
| `NSLayoutXAxisAnchor` | `systemConstraint(to:operator:multiplier:priority:swapItems:)` | システムスペーシングの水平制約 |
| `NSLayoutYAxisAnchor` | `constraint(to:operator:constant:priority:swapItems:)` | 垂直方向のアンカー制約 |
| `NSLayoutYAxisAnchor` | `systemConstraint(to:operator:multiplier:priority:swapItems:)` | システムスペーシングの垂直制約 |
| `NSLayoutDimension` | `constraint(to:operator:constant:multiplier:priority:swapItems:)` | Dimension間の制約 |
| `NSLayoutDimension` | `constraint(to:operator:priority:)` | Dimensionの定数制約 |

### LayoutProxy

| メソッド | 説明 |
|--------|-------------|
| `edgeConstraints(to:edges:constant:priority:)` | 指定した辺を別のアンカーアクセッサにピン留め |
| `sizeConstraints(to:operator:multiplier:)` | 幅と高さを同一の値に設定 |
| `centerConstraints(to:)` | 水平・垂直の両軸で中央揃え |
| `centerXConstraints(to:)` | 水平方向の中央揃え |
| `centerYConstraints(to:)` | 垂直方向の中央揃え |

### NSLayoutConstraintのチェイン可能な修飾子

`constant(_:)` · `priority(_:)` · `activate(with:)` · `activated()` · `deactivated()`

## ライセンス

詳細は[LICENSE](LICENSE)を確認ください。
