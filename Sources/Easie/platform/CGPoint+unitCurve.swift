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

import Foundation
import CoreGraphics

extension UnitCurve {
	/// Return the curve position between two points
	/// - Parameters:
	///   - p0: The first point
	///   - p1: The second point
	///   - t: A unit time value
	/// - Returns: The interpolated point value
	public func value(_ p0: CGPoint, _ p1: CGPoint, at t: Double) -> CGPoint {
		let position = self.value(at: t.unitClamped())
		return CGPoint(
			x: lerp(p0.x, p1.x, t: position),
			y: lerp(p0.y, p1.y, t: position)
		)
	}

	/// Return curve positions between two points
	/// - Parameters:
	///   - p0: The first point
	///   - p1: The second point
	///   - t: An array of unit time values
	/// - Returns: An array of interpolated points
	public func values(_ p0: CGPoint, _ p1: CGPoint, at t: [Double]) -> [CGPoint] {
		assert(t.count > 0)
		return t.map { self.value(p0, p1, at: $0) }
	}

	/// Return equidistant curve positions between two points
	/// - Parameters:
	///   - p0: The first point
	///   - p1: The second point
	///   - count: The number of points (must be > 1)
	/// - Returns: The interpolated point values
	public func values(_ p0: CGPoint, _ p1: CGPoint, count: Int) -> [CGPoint] {
		assert(count > 1)
		let dx: Double = 1.0 / Double(count - 1)
		return stride(from: 0, through: 1, by: dx)
			.map { self.value(p0, p1, at: $0) }
	}
}

#endif
