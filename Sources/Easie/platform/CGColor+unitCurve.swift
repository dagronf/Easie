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

extension UnitCurve {
	/// Return an interpolated color between two points
	/// - Parameters:
	///   - t: A unit time value
	///   - c0: The first color
	///   - c1: The second color
	/// - Returns: The interpolated color value
	public func value(at t: Double, from c0: CGColor, through c1: CGColor) throws -> CGColor {
		try c0.mix(with: c1, by: t.unitClamped())
	}

	/// Return an array of interpolated colors between two points
	/// - Parameters:
	///   - t: A unit time values
	///   - c0: The first color
	///   - c1: The second color
	/// - Returns: The interpolated color values
	public func values(at t: [Double], from c0: CGColor, through c1: CGColor) throws -> [CGColor] {
		try t.map { try c0.mix(with: c1, by: $0) }
	}

	/// Return equally spaced colors between two colors
	/// - Parameters:
	///   - count: The number of equally spaced colors
	///   - c0: The first color
	///   - c1: The last color
	/// - Returns: An array of colors
	public func values(count: Int, from c0: CGColor, through c1: CGColor) throws -> [CGColor] {
		try self.values(at: equallySpacedUnitValues(count), from: c0, through: c1)
	}
}

#endif
