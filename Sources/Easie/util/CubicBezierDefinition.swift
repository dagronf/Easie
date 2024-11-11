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

/// A Cubic Bezier point
struct _CubicPoint {
	let x: Double
	let y: Double
}

/// Cubic bezier
struct _CubicBezier {
	let p0: _CubicPoint
	let p1: _CubicPoint
	let p2: _CubicPoint
	let p3: _CubicPoint

	/// Calculate point on cubic Bezier curve at time t (0 ... 1)
	///
	/// `B(t) = (1-t)³P₀ + 3(1-t)²tP₁ + 3(1-t)t²P₂ + t³P₃`
	func point(at t: Double) -> _CubicPoint {
		assert(t.isInRange(0 ... 1))

		let t2 = t * t
		let t3 = t2 * t
		let mt = 1.0 - t
		let mt2 = mt * mt
		let mt3 = mt2 * mt

		return _CubicPoint(
			x: (self.p0.x * mt3) + (3.0 * self.p1.x * mt2 * t) + (3.0 * self.p2.x * mt * t2) + (self.p3.x * t3),
			y: (self.p0.y * mt3) + (3.0 * self.p1.y * mt2 * t) + (3.0 * self.p2.y * mt * t2) + (self.p3.y * t3)
		)
	}
}
