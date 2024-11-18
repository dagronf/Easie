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

/// Linear interpret between two values
/// - Parameters:
///   - v0: value 1
///   - v1: value 2
///   - t: unit time value
/// - Returns: Linearlly interpolated value
@inlinable public func lerp(_ v0: Double, _ v1: Double, t: Double) -> Double {
	return v0 + ((v1 - v0) * t)
}

/// Return equally spaced values within the unit range (0.0 ... 1.0)
/// - Parameter count: The number of values
/// - Returns: An array of equally spaced unit values
public func unitMappedCountValues(_ count: Int) -> [Double] {
	let dx = 1.0 / Double(count - 1)
	return stride(from: 0.0, through: 1.0, by: dx).map { $0 }
}
