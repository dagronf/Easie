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

/// A cubic bezier curve
///
/// A Cubic Bezier curve is defined by four points P0, P1, P2, and P3. P0 and P3 are the start and the end of
/// the curve and, these points are fixed as the coordinates are ratios. P0 is (0, 0) and represents the initial time
/// and the initial state, P3 is (1, 1) and represents the final time and the final state.
///
/// See: [developer.mozilla.org](https://developer.mozilla.org/en-US/docs/Web/CSS/easing-function#cubic_bézier_easing_function)
public struct CubicBezier: UnitCurve {
	private let bezier: _CubicBezier
	/// Easing function title
	public var title: String {
		"CubicBezier(\(self.bezier.p1.x),\(self.bezier.p1.y),\(self.bezier.p2.x),\(self.bezier.p2.y))"
	}

	/// Create a cubic bezier easing function
	public init(x1: Double, y1: Double, x2: Double, y2: Double) {
		assert(x1.isInRange(0 ... 1))
		assert(x2.isInRange(0 ... 1))
		self.bezier = _CubicBezier(
			 p0: _CubicPoint(x: 0, y: 0),
			 p1: _CubicPoint(x: x1, y: y1),
			 p2: _CubicPoint(x: x2, y: y2),
			 p3: _CubicPoint(x: 1, y: 1)
		)
	}

	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	public func value(at t: Double) -> Double {
		self.bezier.point(at: t.unitClamped()).y
	}
}
