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

public enum CGColorErrors: Error {
	case cannotConvertColorspace
}

private let _extractSRGBcs = CGColorSpace(name: CGColorSpace.sRGB)!

extension CGColor {
	typealias RGBAComponents = (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)

	/// Returns the RGBA components for this color
	///
	/// Throws an error if the color cannot be represented in the sRGB colorspace
	func rgbaComponents() throws -> RGBAComponents {
		guard
			let c1 = self.converted(to: _extractSRGBcs, intent: .defaultIntent, options: nil),
			let c1c = c1.components,
			c1c.count == 4
		else {
			throw CGColorErrors.cannotConvertColorspace
		}
		return RGBAComponents(r: c1c[0], g: c1c[1], b: c1c[2], a: c1c[3])
	}
}

#endif
