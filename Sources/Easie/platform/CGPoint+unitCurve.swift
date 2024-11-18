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

#if canImport(CoreGraphics)

import CoreGraphics
import Foundation

public extension UnitCurve {
	/// Return the curve position between two points
	/// - Parameters:
	///   - t: A unit time value
	///   - p0: The first point
	///   - p1: The second point
	/// - Returns: The interpolated point value
	func value(at t: Double, from p0: CGPoint, through p1: CGPoint) -> CGPoint {
		let position = self.value(at: t.unitClamped())
		return CGPoint(
			x: lerp(p0.x, p1.x, t: position),
			y: lerp(p0.y, p1.y, t: position)
		)
	}

	/// Return curve positions between two points
	/// - Parameters:
	///   - t: An array of unit time values
	///   - p0: The first point
	///   - p1: The second point
	/// - Returns: An array of interpolated points
	func values(at t: [Double], from p0: CGPoint, through p1: CGPoint) -> [CGPoint] {
		t.map { self.value(at: $0, from: p0, through: p1) }
	}

	/// Return equidistant curve positions between two points
	/// - Parameters:
	///   - count: The number of points (must be > 1)
	///   - p0: The first point
	///   - p1: The second point
	/// - Returns: The interpolated point values
	func values(count: Int, from p0: CGPoint, through p1: CGPoint) -> [CGPoint] {
		equallySpacedUnitValues(count).map {
			self.value(at: $0, from: p0, through: p1)
		}
	}
}

#endif
