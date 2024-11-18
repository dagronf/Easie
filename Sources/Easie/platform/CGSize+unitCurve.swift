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
	/// Return the position value for the curve at t
	/// - Parameters:
	///   - xValue: The x value (0 ... size.width)
	///   - size: The size
	/// - Returns: A position value (0 ... size.height)
	@inlinable func value(x: Double, in size: CGSize) -> Double {
		let x = max(0, min(size.width, x))
		let t = x / size.width
		return lerp(0, size.height, t: self.value(at: t))
	}

	/// Return the positions value for the curve at t
	/// - Parameters:
	///   - t: The x values (0 ... size.width)
	///   - size: The curve size
	/// - Returns:Position values (0 ... size.height)
	@inlinable func values(x: [Double], in size: CGSize) -> [Double] {
		x.map { self.value(x: $0, in: size) }
	}
}

public extension UnitCurve {
	/// Return the curve position between two sizes
	/// - Parameters:
	///   - t: A unit time value 0.0 ... 1.0
	///   - from: The first size
	///   - through: The second size
	/// - Returns: The interpolated point value
	func value(at t: Double, from s0: CGSize, through s1: CGSize) -> CGSize {
		let position = self.value(at: t.unitClamped())
		return CGSize(
			width: lerp(s0.width, s1.width, t: position),
			height: lerp(s0.height, s1.height, t: position)
		)
	}

	/// Return curve positions between two sizes
	/// - Parameters:
	///   - t: An array of unit time values
	///   - from: The first size
	///   - through: The second size
	/// - Returns: An array of interpolated sizes
	@inlinable func values(at t: [Double], from s0: CGSize, through s1: CGSize) -> [CGSize] {
		t.map { self.value(at: $0, from: s0, through: s1) }
	}

	/// Return equidistant curve positions between two sizes
	/// - Parameters:
	///   - count: The number of frames (must be > 1)
	///   - from: The first size
	///   - through: The second size
	/// - Returns: The interpolated point values
	func values(count: Int, from s0: CGSize, through s1: CGSize) -> [CGSize] {
		self.values(at: equallySpacedUnitValues(count), from: s0, through: s1)
	}
}

#endif
