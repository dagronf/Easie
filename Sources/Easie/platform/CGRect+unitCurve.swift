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
	/// Return the position value for the input value
	/// - Parameters:
	///   - x: The x value, between rect.minX and rect.maxX
	///   - rect: The input rectangle
	/// - Returns: The position for the curve, mapped between rect.minY and rect.maxY
	func value(at x: Double, in rect: CGRect) -> Double {
		let x = max(rect.minX, min(rect.maxX, x))
		let dt = x / rect.width
		return lerp(rect.minY, rect.maxY, t: self.value(at: dt))
	}

	/// Return the position values for the input values
	/// - Parameters:
	///   - x: The x values, between rect.minX and rect.maxX
	///   - rect: The input rectangle
	/// - Returns: The position for the curve, mapped between rect.minY and rect.maxY
	@inlinable func values(at x: [Double], in rect: CGRect) -> [Double] {
		x.map { self.value(at: $0, in: rect) }
	}
}

public extension UnitCurve {
	/// Return a curve interpolated rect value between two rects
	/// - Parameters:
	///   - t: The time value (0.0 ... 1.0)
	///   - r0: The initial rect
	///   - r1: The final rect
	/// - Returns: An interpolated rect
	func value(at t: Double, from r0: CGRect, through r1: CGRect) -> CGRect {
		let t = t.unitClamped()
		return CGRect(
			x: self.value(at: t, from: r0.minX, through: r1.minX),
			y: self.value(at: t, from: r0.minY, through: r1.minY),
			width: self.value(at: t, from: r0.width, through: r1.width),
			height: self.value(at: t, from: r0.height, through: r1.height)
		)
	}
}

#endif
