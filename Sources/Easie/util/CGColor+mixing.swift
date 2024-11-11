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

private let _extractSRGBcs = CGColorSpace(name: CGColorSpace.sRGB)!

extension CGColor {
	/// Mix two color in the RGBA colorspace
	/// - Parameters:
	///   - color: color to mix into this color
	///   - fraction: The amount of color to mix in
	/// - Returns: A new color
	func mix(with color: CGColor, by fraction: Double) throws -> CGColor {
		let c1 = try self.rgbaComponents()
		let c2 = try color.rgbaComponents()

		let fraction = fraction.unitClamped()
		let r = (c1.r + (fraction * (c2.r - c1.r))).unitClamped()
		let g = (c1.g + (fraction * (c2.g - c1.g))).unitClamped()
		let b = (c1.b + (fraction * (c2.b - c1.b))).unitClamped()
		let a = (c1.a + (fraction * (c2.a - c1.a))).unitClamped()

		guard let c = CGColor(colorSpace: _extractSRGBcs, components: [r, g, b, a]) else {
			throw NSError(domain: "CGColor", code: -3)
		}
		return c
	}
}

#endif
