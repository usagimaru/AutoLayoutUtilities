//
//  AppDelegate.swift
//  AutoLayoutUtilitiesDemo
//
//  Created by usagimaru on 2026/04/09.
//

import Cocoa
import AutoLayoutUtilities

@main
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet var window: NSWindow!

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		guard let contentView = window.contentView else { return }
		contentView.wantsLayer = true

		setupDemos(in: contentView)
	}


	// MARK: - Demos

	/// デモ用の色つきビューを生成
	private func makeBox(color: NSColor, alpha: CGFloat = 1.0) -> NSView {
		let view = NSView()
		view.wantsLayer = true
		view.layer?.backgroundColor = color.withAlphaComponent(alpha).cgColor
		return view
	}

	private func setupDemos(in container: NSView) {
		// MARK: Demo 1 — edgeConstraints: 四辺ピン留め（マージンつき）

		let backgroundView = makeBox(color: .systemBlue, alpha: 0.1)
		container.addSubview(backgroundView) { subview, parentView in
			subview.layout.edgeConstraints(to: parentView, constant: 20)
		}


		// MARK: Demo 2 — sizeConstraints + centerX/centerY: 固定サイズの中央配置

		let centeredBox = makeBox(color: .systemRed)
		backgroundView.addSubview(centeredBox) { subview, parentView in
			subview.layout.centerConstraints(to: parentView) +
			subview.layout.sizeConstraints(to: 80)
		}


		// MARK: Demo 3 — アンカーの個別指定: コーナーへの配置

		let topLeftLabel = NSTextField(labelWithString: "Top Left")
		backgroundView.addSubview(topLeftLabel) { subview, parentView in
			[
				subview.layout.top.systemConstraint(to: parentView.layout.top),
				subview.layout.leading.systemConstraint(to: parentView.layout.leading),
				subview.layout.trailing.systemConstraint(to: parentView.layout.trailing, operator: .greaterThanOrEqualTo, priority: .defaultHigh, swapItems: true),
			]
		}

		let bottomRightLabel = NSTextField(labelWithString: "Bottom Right")
		backgroundView.addSubview(bottomRightLabel) { subview, parentView in
			[
				subview.layout.leading.systemConstraint(to: parentView.layout.leading, operator: .greaterThanOrEqualTo, priority: .defaultHigh),
				subview.layout.bottom.systemConstraint(to: parentView.layout.bottom, swapItems: true),
				subview.layout.trailing.systemConstraint(to: parentView.layout.trailing, swapItems: true),
			]
		}


		// MARK: Demo 4 — 相対配置 + Dimension制約: 別ビューを基準にした配置

		let relativeBox = makeBox(color: .systemGreen, alpha: 0.8)
		relativeBox.translatesAutoresizingMaskIntoConstraints = false
		backgroundView.addSubview(relativeBox)
		[
			// centeredBoxの下に16pt間隔で配置
			relativeBox.layout.top.constraint(to: centeredBox.layout.bottom, constant: 20),
			// centeredBoxと水平中央を揃える
			relativeBox.layout.centerX.constraint(to: centeredBox.layout.centerX),
			// centeredBoxと同じ幅
			relativeBox.layout.width.constraint(to: centeredBox.layout.width),
			// 高さ固定
			relativeBox.layout.height.constraint(to: 40),
		].activate()
	}

}

