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

/// Ease out
/// - Parameters:
///   - type: The easing type
///   - t: A unit time value
/// - Returns: The unit eased position
public func easeOut(_ type: EasingFunctionType = .cubic, at t: Double) -> Double {
	let t = t.unitClamped()
	switch type {
	case .linear: return t
	case .sine: return sin(t * Double.pi / 2)
	case .cubic: return 1.0 - pow(1 - t, 3)
	case .quint: return 1.0 - pow(1 - t, 5)
	case .circ: return sqrt(1.0 - pow(t - 1, 2))
	case .quad: return 1.0 - (1.0 - t) * (1.0 - t)
	case .quart: return 1.0 - pow(1.0 - t, 4.0)
	case .expo: return (t == 1) ? 1.0 : 1.0 - pow(2.0, -10.0 * t)
	case .bounce: return EaseOutBounce().value(at: t)
	case .elastic: return EaseOutElastic().value(at: t)
	case .back: return EaseOutBack().value(at: t)
	}
}

/// Ease out
public struct EaseOut: UnitCurve {
	/// The easing type
	public let type: EasingFunctionType
	/// Create an easing function
	public init(type: EasingFunctionType = .cubic) {
		self.type = type
	}
	/// The title for the easing function
	public var title: String { "easeOut(\(self.type))" }
	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	@inlinable public func value(at t: Double) -> Double { easeOut(self.type, at: t) }
}
