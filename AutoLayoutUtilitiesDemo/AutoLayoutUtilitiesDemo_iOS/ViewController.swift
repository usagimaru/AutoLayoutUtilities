//
//  ViewController.swift
//  AutoLayoutUtilitiesDemo_iOS
//
//  Created by usagimaru on 2026/04/09.
//

import UIKit
import AutoLayoutUtilities

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground

		setupDemos(in: view)
	}


	// MARK: - Demos

	/// デモ用の色つきビューを生成
	private func makeBox(color: UIColor, alpha: CGFloat = 1.0) -> UIView {
		let view = UIView()
		view.backgroundColor = color.withAlphaComponent(alpha)
		return view
	}

	private func setupDemos(in container: UIView) {
		// MARK: Demo 1 — edgeConstraints: 四辺ピン留め（マージンつき）

		let backgroundView = makeBox(color: .systemBlue, alpha: 0.1)
		container.addSubview(backgroundView) { subview, parentView in
			subview.layout.edgeConstraints(to: parentView.safeAreaLayoutGuide, constant: 20)
		}


		// MARK: Demo 2 — sizeConstraints + centerX/centerY: 固定サイズの中央配置

		let centeredBox = makeBox(color: .systemRed)
		backgroundView.addSubview(centeredBox) { subview, parentView in
			subview.layout.centerConstraints(to: parentView) +
			subview.layout.sizeConstraints(to: 80)
		}


		// MARK: Demo 3 — アンカーの個別指定: コーナーへの配置

		let topLeftLabel = UILabel()
		topLeftLabel.text = "Top Left"
		backgroundView.addSubview(topLeftLabel) { subview, parentView in
			[
				subview.layout.top.systemConstraint(to: parentView.layout.top),
				subview.layout.leading.systemConstraint(to: parentView.layout.leading),
				subview.layout.trailing.systemConstraint(to: parentView.layout.trailing, operator: .greaterThanOrEqualTo, priority: .defaultHigh, swapItems: true),
			]
		}

		let bottomRightLabel = UILabel()
		bottomRightLabel.text = "Bottom Right"
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
			// centeredBoxの下に20pt間隔で配置
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
