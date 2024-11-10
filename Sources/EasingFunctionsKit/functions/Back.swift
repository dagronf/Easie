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

public struct EaseInBack: UnitCurve {
	private static let c1: Double = 1.70158
	private static let c3: Double = c1 + 1
	/// The title for the easing function
	public var title: String { "easeInBack" }
	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	public func value(at t: Double) -> Double {
		let t = t.unitClamped()
		return Self.c3 * t * t * t - Self.c1 * t * t
	}
}

public struct EaseOutBack: UnitCurve {
	private static let c1: Double = 1.70158
	private static let c3: Double = c1 + 1
	/// The title for the easing function
	public var title: String { "easeOutBack" }
	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	public func value(at t: Double) -> Double {
		let t = t.unitClamped()
		return 1 + Self.c3 * pow(t - 1, 3) + Self.c1 * pow(t - 1, 2)
	}
}

/// https://easings.net/#easeInOutBack
public struct EaseInEaseOutBack: UnitCurve {
	private static let c1: Double = 1.70158
	private static let c2: Double = c1 * 1.525
	/// The title for the easing function
	public var title: String { "easeInEaseOutBack" }
	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	public func value(at t: Double) -> Double {
		let t = t.unitClamped()
		if t < 0.5 {
			return (pow(2.0 * t, 2.0) * ((Self.c2 + 1.0) * 2.0 * t - Self.c2)) / 2.0
		}
		else {
			return (pow(2.0 * t - 2.0, 2.0) * ((Self.c2 + 1.0) * (t * 2.0 - 2.0) + Self.c2) + 2.0) / 2.0
		}
	}
}
