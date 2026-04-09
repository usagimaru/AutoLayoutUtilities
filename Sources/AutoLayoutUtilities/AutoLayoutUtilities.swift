//
//  AutoLayoutUtilities.swift
//
//  Created by usagimaru on 2026/01/21.
//
//  Utilities for Auto Layout

#if canImport(AppKit)
import AppKit
public typealias PlatformView = NSView
public typealias LayoutPriority = NSLayoutConstraint.Priority
#elseif canImport(UIKit)
import UIKit
public typealias PlatformView = UIView
public typealias LayoutPriority = UILayoutPriority
#endif

extension NSLayoutXAxisAnchor {

	@discardableResult
	public func constraint(to another: NSLayoutXAxisAnchor,
						   operator: NSLayoutConstraint.CalculationOperator = .equalTo,
						   constant: CGFloat = 0,
						   priority: LayoutPriority = .required,
						   swapItems: Bool = false) -> NSLayoutConstraint
	{
		let item1 = swapItems ? another : self
		let item2 = swapItems ? self : another

		switch `operator` {
			case .equalTo:
				return item1.constraint(equalTo: item2, constant: constant)
					.priority(priority)

			case .greaterThanOrEqualTo:
				return item1.constraint(greaterThanOrEqualTo: item2, constant: constant)
					.priority(priority)

			case .lessThanOrEqualTo:
				return item1.constraint(lessThanOrEqualTo: item2, constant: constant)
					.priority(priority)
		}
	}

	@discardableResult
	public func systemConstraint(to another: NSLayoutXAxisAnchor,
								 operator: NSLayoutConstraint.CalculationOperator = .equalTo,
								 multiplier: CGFloat = 1,
								 priority: LayoutPriority = .required,
								 swapItems: Bool = false) -> NSLayoutConstraint
	{
		let item1 = swapItems ? another : self
		let item2 = swapItems ? self : another

		switch `operator` {
			case .equalTo:
				return item1.constraint(equalToSystemSpacingAfter: item2, multiplier: multiplier)
					.priority(priority)

			case .greaterThanOrEqualTo:
				return item1.constraint(greaterThanOrEqualToSystemSpacingAfter: item2, multiplier: multiplier)
					.priority(priority)

			case .lessThanOrEqualTo:
				return item1.constraint(lessThanOrEqualToSystemSpacingAfter: item2, multiplier: multiplier)
					.priority(priority)
		}
	}

}

extension NSLayoutYAxisAnchor {

	@discardableResult
	public func constraint(to another: NSLayoutYAxisAnchor,
						   operator: NSLayoutConstraint.CalculationOperator = .equalTo,
						   constant: CGFloat = 0,
						   priority: LayoutPriority = .required,
						   swapItems: Bool = false) -> NSLayoutConstraint
	{
		let item1 = swapItems ? another : self
		let item2 = swapItems ? self : another

		switch `operator` {
			case .equalTo:
				return item1.constraint(equalTo: item2, constant: constant)
					.priority(priority)

			case .greaterThanOrEqualTo:
				return item1.constraint(greaterThanOrEqualTo: item2, constant: constant)
					.priority(priority)

			case .lessThanOrEqualTo:
				return item1.constraint(lessThanOrEqualTo: item2, constant: constant)
					.priority(priority)
		}
	}

	@discardableResult
	public func systemConstraint(to another: NSLayoutYAxisAnchor,
								 operator: NSLayoutConstraint.CalculationOperator = .equalTo,
								 multiplier: CGFloat = 1,
								 priority: LayoutPriority = .required,
								 swapItems: Bool = false) -> NSLayoutConstraint
	{
		let item1 = swapItems ? another : self
		let item2 = swapItems ? self : another

		switch `operator` {
			case .equalTo:
				return item1.constraint(equalToSystemSpacingBelow: item2, multiplier: multiplier)
					.priority(priority)

			case .greaterThanOrEqualTo:
				return item1.constraint(greaterThanOrEqualToSystemSpacingBelow: item2, multiplier: multiplier)
					.priority(priority)

			case .lessThanOrEqualTo:
				return item1.constraint(lessThanOrEqualToSystemSpacingBelow: item2, multiplier: multiplier)
					.priority(priority)
		}
	}

}

extension NSLayoutDimension {

	@discardableResult
	public func constraint(to another: NSLayoutDimension,
						   operator: NSLayoutConstraint.CalculationOperator = .equalTo,
						   constant: CGFloat = 0,
						   multiplier: CGFloat = 1,
						   priority: LayoutPriority = .required,
						   swapItems: Bool = false) -> NSLayoutConstraint
	{
		let item1 = swapItems ? another : self
		let item2 = swapItems ? self : another

		switch `operator` {
			case .equalTo:
				return item1.constraint(equalTo: item2, multiplier: multiplier, constant: constant)
					.priority(priority)

			case .greaterThanOrEqualTo:
				return item1.constraint(greaterThanOrEqualTo: item2, multiplier: multiplier, constant: constant)
					.priority(priority)

			case .lessThanOrEqualTo:
				return item1.constraint(lessThanOrEqualTo: item2, multiplier: multiplier, constant: constant)
					.priority(priority)
		}
	}

	@discardableResult
	public func constraint(to constant: CGFloat,
						   operator: NSLayoutConstraint.CalculationOperator = .equalTo,
						   priority: LayoutPriority = .required) -> NSLayoutConstraint
	{
		switch `operator` {
			case .equalTo:
				return constraint(equalToConstant: constant)
					.priority(priority)

			case .greaterThanOrEqualTo:
				return constraint(greaterThanOrEqualToConstant: constant)
					.priority(priority)

			case .lessThanOrEqualTo:
				return constraint(lessThanOrEqualToConstant: constant)
					.priority(priority)
		}
	}

}

extension NSLayoutConstraint {

	public enum CalculationOperator {
		case equalTo
		case greaterThanOrEqualTo
		case lessThanOrEqualTo
	}

	public enum Edges: CaseIterable {
		case top
		case bottom
		case leading
		case trailing
	}

	@discardableResult
	public func constant(_ value: CGFloat) -> NSLayoutConstraint {
		constant = value
		return self
	}

	@discardableResult
	public func priority(_ value: LayoutPriority) -> NSLayoutConstraint {
		priority = value
		return self
	}

	@discardableResult
	public func activate(with flag: Bool = true) -> NSLayoutConstraint {
		isActive = flag
		return self
	}

	@discardableResult
	public func activated() -> NSLayoutConstraint {
		isActive = true
		return self
	}

	@discardableResult
	public func deactivated() -> NSLayoutConstraint {
		isActive = false
		return self
	}

}

extension Array<NSLayoutConstraint> {

	@MainActor @discardableResult
	public func activate() -> Self {
		NSLayoutConstraint.activate(self)
		return self
	}

	@MainActor @discardableResult
	public func deactivate() -> Self {
		NSLayoutConstraint.deactivate(self)
		return self
	}

}

@MainActor
public protocol LayoutAnchorAccessor {

	var topAnchor: NSLayoutYAxisAnchor { get }
	var bottomAnchor: NSLayoutYAxisAnchor { get }
	var leadingAnchor: NSLayoutXAxisAnchor { get }
	var trailingAnchor: NSLayoutXAxisAnchor { get }
	var leftAnchor: NSLayoutXAxisAnchor { get }
	var rightAnchor: NSLayoutXAxisAnchor { get }
	var widthAnchor: NSLayoutDimension { get }
	var heightAnchor: NSLayoutDimension { get }
	var centerXAnchor: NSLayoutXAxisAnchor { get }
	var centerYAnchor: NSLayoutYAxisAnchor { get }

}

extension LayoutAnchorAccessor {

	public var layout: LayoutProxy<Self> {
		LayoutProxy(owner: self)
	}

}

#if canImport(AppKit)
extension NSView: LayoutAnchorAccessor {}
extension NSLayoutGuide: LayoutAnchorAccessor {}
#elseif canImport(UIKit)
extension UIView: LayoutAnchorAccessor {}
extension UILayoutGuide: LayoutAnchorAccessor {}
#endif


// MARK: - LayoutProxy

@MainActor
public struct LayoutProxy<Owner: LayoutAnchorAccessor> {

	public let owner: Owner

	public var top: NSLayoutYAxisAnchor { owner.topAnchor }
	public var bottom: NSLayoutYAxisAnchor { owner.bottomAnchor }
	public var leading: NSLayoutXAxisAnchor { owner.leadingAnchor }
	public var trailing: NSLayoutXAxisAnchor { owner.trailingAnchor }
	public var left: NSLayoutXAxisAnchor { owner.leftAnchor }
	public var right: NSLayoutXAxisAnchor { owner.rightAnchor }
	public var width: NSLayoutDimension { owner.widthAnchor }
	public var height: NSLayoutDimension { owner.heightAnchor }
	public var centerX: NSLayoutXAxisAnchor { owner.centerXAnchor }
	public var centerY: NSLayoutYAxisAnchor { owner.centerYAnchor }

	@discardableResult
	public func edgeConstraints(operator o: NSLayoutConstraint.CalculationOperator = .equalTo,
								to item: some LayoutAnchorAccessor,
								edges: Set<NSLayoutConstraint.Edges> = Set(NSLayoutConstraint.Edges.allCases),
								constant c: CGFloat = 0,
								priority p: LayoutPriority = .required) -> [NSLayoutConstraint]
	{
		var constraints = [NSLayoutConstraint]()

		if !edges.isEmpty {
			(owner as? PlatformView)?.translatesAutoresizingMaskIntoConstraints = false
		}

		if edges.contains(.top) {
			constraints.append(
				top.constraint(to: item.topAnchor, operator: o, constant: c, priority: p, swapItems: false)
			)
		}
		if edges.contains(.bottom) {
			constraints.append(
				bottom.constraint(to: item.bottomAnchor, operator: o, constant: c, priority: p, swapItems: true)
			)
		}
		if edges.contains(.leading) {
			constraints.append(
				leading.constraint(to: item.leadingAnchor, operator: o, constant: c, priority: p, swapItems: false)
			)
		}
		if edges.contains(.trailing) {
			constraints.append(
				trailing.constraint(to: item.trailingAnchor, operator: o, constant: c, priority: p, swapItems: true)
			)
		}

		return constraints
	}

	@discardableResult
	public func sizeConstraints(to constant: CGFloat,
								operator o: NSLayoutConstraint.CalculationOperator = .equalTo,
								multiplier: CGFloat = 1,
								priorityWidth: LayoutPriority = .required,
								priorityHeight: LayoutPriority = .required) -> [NSLayoutConstraint]
	{
		(owner as? PlatformView)?.translatesAutoresizingMaskIntoConstraints = false
		
		return [
			width.constraint(to: constant * multiplier, operator: o, priority: priorityWidth),
			height.constraint(to: constant * multiplier, operator: o, priority: priorityHeight),
		]
	}
	
	@discardableResult
	public func centerConstraints(to: LayoutAnchorAccessor,
								  operator o: NSLayoutConstraint.CalculationOperator = .equalTo,
								  multiplier: CGFloat = 1,
								  constant: CGFloat = 0,
								  priorityX: LayoutPriority = .required,
								  priorityY: LayoutPriority = .required) -> [NSLayoutConstraint]
	{
		(owner as? PlatformView)?.translatesAutoresizingMaskIntoConstraints = false
		
		return [
			centerX.constraint(to: to.centerXAnchor, operator: o, constant: constant, priority: priorityX, swapItems: false),
			centerY.constraint(to: to.centerYAnchor, operator: o, constant: constant, priority: priorityY, swapItems: false),
		]
	}
	
	@discardableResult
	public func centerXConstraints(to: LayoutAnchorAccessor,
								  operator o: NSLayoutConstraint.CalculationOperator = .equalTo,
								  multiplier: CGFloat = 1,
								  constant: CGFloat = 0,
								  priority: LayoutPriority = .required) -> NSLayoutConstraint
	{
		(owner as? PlatformView)?.translatesAutoresizingMaskIntoConstraints = false
		return centerX.constraint(to: to.centerXAnchor, operator: o, constant: constant, priority: priority, swapItems: false)
	}
	
	@discardableResult
	public func centerYConstraints(to: LayoutAnchorAccessor,
								   operator o: NSLayoutConstraint.CalculationOperator = .equalTo,
								   multiplier: CGFloat = 1,
								   constant: CGFloat = 0,
								   priority: LayoutPriority = .required) -> NSLayoutConstraint
	{
		(owner as? PlatformView)?.translatesAutoresizingMaskIntoConstraints = false
		return centerY.constraint(to: to.centerYAnchor, operator: o, constant: constant, priority: priority, swapItems: false)
	}

}

#if canImport(AppKit)
extension NSView {

	public func addSubview(_ view: NSView,
						   positioned place: NSWindow.OrderingMode? = nil,
						   relativeTo otherView: NSView? = nil,
						   constraints: @escaping (_ subview: NSView, _ parentView: NSView) -> [NSLayoutConstraint])
	{
		if let place {
			addSubview(view, positioned: place, relativeTo: otherView)
		}
		else {
			addSubview(view)
		}
		view.translatesAutoresizingMaskIntoConstraints = false
		constraints(view, self).activate()
	}

}

#elseif canImport(UIKit)
extension UIView {

	public func addSubview(_ view: UIView,
						   constraints: @escaping (_ subview: UIView, _ parentView: UIView) -> [NSLayoutConstraint])
	{
		addSubview(view)
		view.translatesAutoresizingMaskIntoConstraints = false
		constraints(view, self).activate()
	}

}
#endif

extension PlatformView {

	public func removeConstraint(with identifier: String) {
		removeConstraints(with: [identifier])
	}

	public func removeConstraints(with identifiers: [String]) {
		let targetConstraints = constraints.filter {
			if let identifier = $0.identifier {
				return identifiers.contains(identifier)
			}
			return false
		}
		removeConstraints(targetConstraints)
	}

}
