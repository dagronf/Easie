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

// MARK: - Ease In Ease Out

/// Ease in, ease out
/// - Parameters:
///   - type: The easing type
///   - t: A unit time value
/// - Returns: The unit eased position
public func easeInEaseOut(_ type: EasingFunctionType = .cubic, at t: Double) -> Double {
	let t = t.unitClamped()
	switch type {
	case .linear:
		return t
	case .sine:
		return -(cos(Double.pi * t) - 1.0) / 2.0
	case .cubic:
		return t < 0.5 ? 4.0 * t * t * t : 1.0 - pow(-2.0 * t + 2.0, 3.0) / 2.0
	case .quint:
		return t < 0.5 ? 16.0 * t * t * t * t * t : 1.0 - pow(-2.0 * t + 2.0, 5.0) / 2.0
	case .circ:
		return t < 0.5
			? (1.0 - sqrt(1.0 - pow(2.0 * t, 2.0))) / 2.0
			: (sqrt(1.0 - pow(-2.0 * t + 2.0, 2.0)) + 1.0) / 2.0
	case .quad:
		return (t < 0.5) ? 2.0 * t * t : 1.0 - pow(-2.0 * t + 2.0, 2.0) / 2.0
	case .quart:
		return (t < 0.5) ? 8.0 * t * t * t * t : 1.0 - pow(-2.0 * t + 2.0, 4.0) / 2.0
	case .expo:
		if t == 0 { return 0 }
		if t == 1 { return 1 }
		return (t < 0.5)
			? pow(2.0, 20.0 * t - 10.0) / 2.0
			: (2.0 - pow(2.0, -20.0 * t + 10.0)) / 2.0
	case .bounce:
		return EaseInEaseOutBounce().value(at: t)
	case .elastic:
		return EaseInEaseOutElastic().value(at: t)
	case .back:
		return EaseInEaseOutBack().value(at: t)
	}
}

/// Ease in ease out
public struct EaseInEaseOut: UnitCurve {
	/// The easing type
	public let type: EasingFunctionType
	/// Create an easing function
	public init(type: EasingFunctionType = .cubic) {
		self.type = type
	}
	/// The title for the easing function
	public var title: String { "easeInEaseOut(\(self.type))" }
	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	@inlinable public func value(at t: Double) -> Double { easeInEaseOut(self.type, at: t) }
}
