[日本語](README_ja.md)

# AutoLayoutUtilities

A lightweight Swift library that provides fluent, chainable helpers for Auto Layout on Apple platforms (macOS AppKit and iOS UIKit). Originally a personal toolkit, now published for public use.

## Features

- Unified API across AppKit and UIKit via platform type aliases
- Chainable constraint creation with `@discardableResult` support
- `LayoutProxy` for concise anchor access (`view.layout.top`, `view.layout.width`, etc.)
- Edge, size, and center constraint helpers that return `[NSLayoutConstraint]`
- Batch `activate()` / `deactivate()` on constraint arrays
- Constraint management by identifier
- `addSubview(_:constraints:)` — add a subview and apply constraints in a single call
    - `translatesAutoresizingMaskIntoConstraints = false` call is no needed.
- Support for comparison operators (equal, greater-than-or-equal, less-than-or-equal) and system spacing

## Requirements

- Swift 6.0+
- iOS 18.0+ / macOS 15.0+

## Installation

### Swift Package Manager

Add the following to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/usagimaru/AutoLayoutUtilities.git", from: "1.0.0"),
]
```

Or in Xcode: **File > Add Package Dependencies…** and enter the repository URL.

## Usage

### Pin edges with `addSubview()`

```swift
container.addSubview(childView) { subview, parentView in
    subview.layout.edgeConstraints(to: parentView.safeAreaLayoutGuide, constant: 20)
}
```

### Center + fixed size with `addSubview()`

```swift
container.addSubview(box) { subview, parentView in
    subview.layout.centerConstraints(to: parentView) +
    subview.layout.sizeConstraints(to: 80)
}
```

### Individual anchor constraints

```swift
[
    viewA.layout.top.constraint(to: viewB.layout.bottom, constant: 20),
    viewA.layout.centerX.constraint(to: viewB.layout.centerX),
    viewA.layout.width.constraint(to: viewB.layout.width),
    viewA.layout.height.constraint(to: 40),
].activate()
```

### System spacing

```swift
[
    label.layout.top.systemConstraint(to: parentView.layout.top),
    label.layout.leading.systemConstraint(to: parentView.layout.leading),
].activate()
```

### swapItems

Use the `swapItems` parameter to swap constraint items when the constant direction is inverted (e.g. bottom / trailing edges). `edgeConstraints()` method applies swapItems for bottom/trailing automatically.

```swift
// For bottom/trailing, the constant direction is inverted — use swapItems to swap constraint items
[
    subview.layout.top.constraint(to: parentView.layout.top, constant: 20),
    subview.layout.leading.constraint(to: parentView.layout.leading, constant: 20),
    subview.layout.bottom.constraint(to: parentView.layout.bottom, constant: 20, swapItems: true), // <---
    subview.layout.trailing.constraint(to: parentView.layout.trailing, constant: 20, swapItems: true), // <---
].activate()
```

## API Overview

### Anchor Extensions

| Type | Method | Description |
|------|--------|-------------|
| `NSLayoutXAxisAnchor` | `constraint(to:operator:constant:priority:swapItems:)` | Horizontal anchor constraint |
| `NSLayoutXAxisAnchor` | `systemConstraint(to:operator:multiplier:priority:swapItems:)` | System-spacing horizontal constraint |
| `NSLayoutYAxisAnchor` | `constraint(to:operator:constant:priority:swapItems:)` | Vertical anchor constraint |
| `NSLayoutYAxisAnchor` | `systemConstraint(to:operator:multiplier:priority:swapItems:)` | System-spacing vertical constraint |
| `NSLayoutDimension` | `constraint(to:operator:constant:multiplier:priority:swapItems:)` | Dimension-to-dimension constraint |
| `NSLayoutDimension` | `constraint(to:operator:priority:)` | Dimension-to-constant constraint |

### LayoutProxy

| Method | Description |
|--------|-------------|
| `edgeConstraints(to:edges:constant:priority:)` | Pin selected edges to another anchor accessor |
| `sizeConstraints(to:operator:multiplier:)` | Set equal width and height |
| `centerConstraints(to:)` | Center both axes |
| `centerXConstraints(to:)` | Center horizontally |
| `centerYConstraints(to:)` | Center vertically |

### NSLayoutConstraint Chainable Modifiers

`constant(_:)` · `priority(_:)` · `activate(with:)` · `activated()` · `deactivated()`

## License

See [LICENSE](LICENSE) for details.
