//
//  Copyright © 2024 Darren Ford. All rights reserved.
//
//  MIT license
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
//  documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial
//  portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
//  WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
//  OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
//  OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import Foundation

// MARK: - Ease In

/// Ease in with bounce
/// - Parameter t: A unit time value
/// - Returns: The unit eased position
public func easeInBounce(at t: Double) -> Double {
	let t = t.unitClamped()
	return 1.0 - easeOutBounce(at: 1.0 - t)
}

/// Ease in with bounce
public struct EaseInBounce: UnitCurve {
	private static let easeOutBounce = EaseOutBounce()
	/// The title for the easing function
	public var title: String { "easeInBounce" }
	/// Create
	public init() { }
	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	@inlinable public func value(at t: Double) -> Double { easeInBounce(at: t) }
}

// MARK: - Ease Out

/// Ease out with bounce
/// - Parameter t: A unit time value
/// - Returns: The unit eased position
public func easeOutBounce(at t: Double) -> Double {
	let t = t.unitClamped()
	if t == 0 { return 0 }
	if t == 1 { return 1 }

	let n1: Double = 7.5625
	let d1: Double = 2.75

	if t < (1.0 / d1) {
		return n1 * t * t
	}
	else if t < (2.0 / d1) {
		let tt = t - (1.5 / d1)
		return n1 * tt * tt + 0.75
	}
	else if t < (2.5 / d1) {
		let tt = t - (2.25 / d1)
		return n1 * tt * tt + 0.9375
	}
	else {
		let tt = t - (2.625 / d1)
		return n1 * (tt / d1) * tt + 0.984375
	}
}

/// Ease out with bounce
public struct EaseOutBounce: UnitCurve {
	/// The title for the easing function
	public var title: String { "easeOutBounce" }
	/// Create
	public init() { }
	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	@inlinable public func value(at t: Double) -> Double { easeOutBounce(at: t) }
}

// MARK: - Ease In Ease Out

/// Ease in. ease out with bounce
/// - Parameter t: A unit time value
/// - Returns: The unit eased position
public func easeInEaseOutBounce(at t: Double) -> Double {
	let t = t.unitClamped()
	return (t < 0.5)
		? (1.0 - easeOutBounce(at: 1.0 - 2.0 * t)) / 2.0
		: (1.0 + easeOutBounce(at: 2.0 * t - 1.0)) / 2.0
}

/// Ease in, ease out with bounce
public struct EaseInEaseOutBounce: UnitCurve {
	private static let easeOutBounce = EaseOutBounce()
	/// The title for the easing function
	public var title: String { "easeInEaseOutBounce" }
	/// Create
	public init() { }
	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	@inlinable public func value(at t: Double) -> Double { easeInEaseOutBounce(at: t) }
}
