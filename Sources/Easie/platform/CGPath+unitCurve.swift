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
	/// Build a CGPath representing the easing curve
	/// - Parameters:
	///   - size: The size of the resulting path
	///   - steps: The number of steps to take along the curve when building the path
	///   - isFlipped: If true, flips the y axis
	/// - Returns: CGPath
	func cgPath(size: CGSize, steps: Int, isFlipped: Bool = false) -> CGPath {
		assert(steps > 2)

		let stepSize: Double = size.width / Double(steps - 1)

		let result = CGMutablePath()
		result.move(to: CGPoint(x: 0, y: isFlipped ? size.height - 1 : 0.0))

		for x in stride(from: stepSize, to: size.width, by: stepSize) {
			let xUnit = x / Double(size.width)
			let yy = self.value(at: xUnit)
			let yUnit = isFlipped ? (1.0 - yy) : yy
			let yVal = yUnit * Double(size.height)
			result.addLine(to: CGPoint(x: x, y: yVal))
		}

		result.addLine(to: CGPoint(x: size.width - 1, y: isFlipped ? 0 : size.height - 1))

		return result
	}
}

#endif
