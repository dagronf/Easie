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
	private let bezier: CubicBezierDef
	/// Easing function title
	public var title: String {
		"CubicBezier(\(self.bezier.p1.x),\(self.bezier.p1.y),\(self.bezier.p2.x),\(self.bezier.p2.y))"
	}
	/// Create a cubic bezier easing function
	public init(x1: Double, y1: Double, x2: Double, y2: Double) {
		assert(x1.isInRange(0 ... 1))
		assert(x2.isInRange(0 ... 1))
		self.bezier = CubicBezierDef(
			 p0: CubicPointDef(x: 0, y: 0),
			 p1: CubicPointDef(x: x1, y: y1),
			 p2: CubicPointDef(x: x2, y: y2),
			 p3: CubicPointDef(x: 1, y: 1)
		)
	}

	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	public func value(at t: Double) -> Double {
		self.bezier.point(at: t.unitClamped()).y
	}
}

// private

private struct CubicPointDef {
	let x: Double
	let y: Double
}

private struct CubicBezierDef {
	let p0: CubicPointDef
	let p1: CubicPointDef
	let p2: CubicPointDef
	let p3: CubicPointDef

	/// Calculate point on cubic Bezier curve at time t (0 ... 1)
	func point(at t: Double) -> CubicPointDef {
		assert(t.isInRange(0 ... 1))

		// B(t) = (1-t)³P₀ + 3(1-t)²tP₁ + 3(1-t)t²P₂ + t³P₃
		let t2 = t * t
		let t3 = t2 * t
		let mt = 1.0 - t
		let mt2 = mt * mt
		let mt3 = mt2 * mt

		return CubicPointDef(
			x: (p0.x * mt3) + (3.0 * p1.x * mt2 * t) + (3.0 * p2.x * mt * t2) + (p3.x * t3),
			y: (p0.y * mt3) + (3.0 * p1.y * mt2 * t) + (3.0 * p2.y * mt * t2) + (p3.y * t3)
		)
	}

//	/// Get an array of points along the curve
//	func points(count: Int) -> [CubicPointDef] {
//		guard count > 1 else { return [ p0 ] }
//		let stepSize = 1.0 / Double(count)
//		return stride(from: 0, through: 1, by: stepSize).map { t in
//			self.point(at: t)
//		}
//	}
//
//	/// Calculate curve length (approximate)
//	func approximateLength(segments: Int = 100) -> Double {
//		 let points = self.points(count: segments)
//		 var length: Double = 0
//
//		 for i in 1 ..< points.count {
//			  let dx = points[i].x - points[i-1].x
//			  let dy = points[i].y - points[i-1].y
//			  length += sqrt(dx*dx + dy*dy)
//		 }
//
//		 return length
//	}
//
//	/// Calculate derivative (tangent vector) at time t (0 - 1)
//	func derivative(at t: Double) -> CubicPointDef {
//		let t2 = t * t
//		let mt = 1 - t
//		let mt2 = mt * mt
//
//		return CubicPointDef(
//			x: 3 * mt2 * (p1.x - p0.x) + 6 * mt * t * (p2.x - p1.x) + 3 * t2 * (p3.x - p2.x),
//			y: 3 * mt2 * (p1.y - p0.y) + 6 * mt * t * (p2.y - p1.y) + 3 * t2 * (p3.y - p2.y)
//		)
//	}
//
// /// Create a CGPath representation of the curve
//	func path() -> CGPath {
//		 let path = CGMutablePath()
//		 path.move(to: p0)
//		 path.addCurve(to: p3, control1: p1, control2: p2)
//		 return path
//	}
}
