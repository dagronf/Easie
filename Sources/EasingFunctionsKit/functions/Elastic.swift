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

/// Ease in elastic curve
public struct EaseInElastic: UnitCurve {
	private static let c4: Double = (2.0 * Double.pi) / 3.0
	/// The title for the easing function
	public var title: String { "easeInElastic" }
	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	public func value(at t: Double) -> Double {
		let t = t.unitClamped()
		if t == 0 { return 0 }
		if t == 1 { return 1 }
		return -pow(2, 10 * t - 10) * sin((t * 10 - 10.75) * Self.c4)
	}
}

/// Ease out elastic curve
struct EaseOutElastic: UnitCurve {
	private static let c4: Double = (2.0 * Double.pi) / 3.0
	/// The title for the easing function
	public var title: String { "easeOutElastic" }
	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	public func value(at t: Double) -> Double {
		let t = t.unitClamped()
		if t == 0 { return 0 }
		if t == 1 { return 1 }
		return pow(2, -10 * t) * sin((t * 10 - 0.75) * Self.c4) + 1.0
	}
}

/// Ease in, ease out elastic curve
struct EaseInEaseOutElastic: UnitCurve {
	private static let c5: Double = (2.0 * Double.pi) / 4.5
	/// The title for the easing function
	public var title: String { "easeInEaseOutElastic" }
	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	public func value(at t: Double) -> Double {
		let t = t.unitClamped()
		switch t {
		case 0: return 0
		case 1: return 1
		case let t where t < 0.5:
			return -(pow(2, 20 * t - 10) * sin((20 * t - 11.125) * Self.c5)) / 2
		case let t where t >= 0.5:
			return (pow(2, -20 * t + 10) * sin((20 * t - 11.125) * Self.c5)) / 2 + 1
		default:
			fatalError()
		}
	}
}
