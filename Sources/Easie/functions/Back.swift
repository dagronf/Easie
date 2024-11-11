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

/// Ease in. Goes slightly backwards before moving forward
///   - t: A unit time value
/// - Returns: The unit eased position
public func easeInBack(_ t: Double) -> Double {
	let t = t.unitClamped()
	let c1: Double = 1.70158
	let c3: Double = c1 + 1
	return c3 * t * t * t - c1 * t * t
}

/// Ease in. Goes slightly backwards before moving forward
public struct EaseInBack: UnitCurve {
	/// The title for the easing function
	public var title: String { "easeInBack" }
	/// Create
	public init() { }
	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	@inlinable public func value(at t: Double) -> Double { easeInBack(t) }
}

// MARK: - Ease Out

/// Ease out. Overshoots then pulls back to 1.0
/// - Parameter t: A unit time value
/// - Returns: The unit eased position
public func easeOutBack(_ t: Double) -> Double {
	let c1: Double = 1.70158
	let c3: Double = c1 + 1
	let t = t.unitClamped()
	return 1 + c3 * pow(t - 1, 3) + c1 * pow(t - 1, 2)
}

/// Ease out. Overshoots then pulls back to 1.0
public struct EaseOutBack: UnitCurve {
	/// The title for the easing function
	public var title: String { "easeOutBack" }
	/// Create
	public init() { }
	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	@inlinable public func value(at t: Double) -> Double { easeOutBack(t) }
}

// MARK: - Ease In Ease Out

/// Ease in, ease out with overshoots at start and end
/// - Parameter t: A unit time value
/// - Returns: The unit eased position
public func easeInEaseOutBack(_ t: Double) -> Double {
	let t = t.unitClamped()
	let c1: Double = 1.70158
	let c2: Double = c1 * 1.525
	if t < 0.5 {
		return (pow(2.0 * t, 2.0) * ((c2 + 1.0) * 2.0 * t - c2)) / 2.0
	}
	else {
		return (pow(2.0 * t - 2.0, 2.0) * ((c2 + 1.0) * (t * 2.0 - 2.0) + c2) + 2.0) / 2.0
	}
}

/// Ease in, ease out with overshoots at start and end
public struct EaseInEaseOutBack: UnitCurve {
	/// The title for the easing function
	public var title: String { "easeInEaseOutBack" }
	/// Create
	public init() { }
	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	@inlinable public func value(at t: Double) -> Double { easeInEaseOutBack(t) }
}
