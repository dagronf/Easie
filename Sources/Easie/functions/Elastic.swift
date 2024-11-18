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

/// Ease in with elasticity
/// - Parameters:
///   - t: A unit time value
/// - Returns: The unit eased position
public func easeInElastic(at t: Double) -> Double {
	let t = t.unitClamped()
	if t == 0 { return 0 }
	if t == 1 { return 1 }
	let c4: Double = (2.0 * Double.pi) / 3.0
	return -pow(2, 10 * t - 10) * sin((t * 10 - 10.75) * c4)
}

/// Ease in with elasticity
public struct EaseInElastic: UnitCurve {
	/// The title for the easing function
	public var title: String { "easeInElastic" }
	/// Create
	public init() { }
	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	@inlinable public func value(at t: Double) -> Double { easeInElastic(at: t) }
}

// MARK: - Ease Out

/// Ease out with elasticity
/// - Parameters:
///   - t: A unit time value
/// - Returns: The unit eased position
public func easeOutElastic(at t: Double) -> Double {
	let t = t.unitClamped()
	if t == 0 { return 0 }
	if t == 1 { return 1 }
	let c4: Double = (2.0 * Double.pi) / 3.0
	return pow(2, -10 * t) * sin((t * 10 - 0.75) * c4) + 1.0
}

/// Ease out with elasticity
struct EaseOutElastic: UnitCurve {
	/// The title for the easing function
	public var title: String { "easeOutElastic" }
	/// Create
	public init() { }
	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	@inlinable public func value(at t: Double) -> Double { easeOutElastic(at: t) }
}

// MARK: - Ease In Ease Out

/// Ease in ease out with elasticity
/// - Parameters:
///   - t: A unit time value
/// - Returns: The unit eased position
public func easeInEaseOutElastic(at t: Double) -> Double {
	let t = t.unitClamped()
	let c5: Double = (2.0 * Double.pi) / 4.5
	switch t {
	case 0: return 0
	case 1: return 1
	case let t where t < 0.5:
		return -(pow(2, 20 * t - 10) * sin((20 * t - 11.125) * c5)) / 2
	case let t where t >= 0.5:
		return (pow(2, -20 * t + 10) * sin((20 * t - 11.125) * c5)) / 2 + 1
	default:
		fatalError()
	}
}

/// Ease in ease out with elasticity
struct EaseInEaseOutElastic: UnitCurve {
	/// The title for the easing function
	public var title: String { "easeInEaseOutElastic" }

	/// Create
	public init() { }
	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	@inlinable public func value(at t: Double) -> Double { easeInEaseOutElastic(at: t) }
}
