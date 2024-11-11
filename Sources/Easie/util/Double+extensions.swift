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

internal extension Double {
	/// Clamp this value to 0.0 ... 1.0
	@inlinable @inline(__always) func unitClamped() -> Double { max(0.0, min(1.0, self)) }

	/// Does this value fall within the range
	/// - Parameter range: The range to check
	/// - Returns: True if this value falls within the range, false otherwise
	@inlinable @inline(__always) func isInRange(_ range: ClosedRange<Double>) -> Bool {
		range.contains(self)
	}

	/// An equality check with a precision accuracy
	/// - Parameters:
	///   - value: The value to compare
	///   - precision: The precision (accuracy) in decimal places (eg. 8 == 8 decimal places)
	/// - Returns: True if mostly equal, false otherwise
	func isEqualTo(_ value: Double, precision: UInt) -> Bool {
		return abs(self - value) < pow(10, -Double(precision))
	}
}
