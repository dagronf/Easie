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

public enum CGGradientErrors: Error {
	case cannotCreateGradient
}

public extension CGGradient {
	/// Build a gradient between two colors using a curve
	/// - Parameters:
	///   - color1: First color
	///   - color2: Second color
	///   - curve: The unit curve to apply
	///   - steps: The number of steps to use when creating the gradient
	/// - Returns: A new gradient object
	static func build(
		from color1: CGColor,
		to color2: CGColor,
		curve: UnitCurve,
		steps: Int = 10
	) throws -> CGGradient {
		let steps = stride(from: 0.0, to: 1.0, by: 1.0 / Double(steps))
		let colors = try steps.map { x in
			try color1.mix(with: color2, by: curve.value(at: x))
		}
		guard let gradient = CGGradient(
			colorsSpace: nil,
			colors: colors as CFArray,
			locations: steps.map { CGFloat($0) }
		)
		else {
			throw CGGradientErrors.cannotCreateGradient
		}
		return gradient
	}
}

#endif
