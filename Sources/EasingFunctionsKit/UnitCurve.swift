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

/// Easing function protocol
public protocol UnitCurve: Sendable {
	/// The title for the easing function
	var title: String { get }
	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	func value(at t: Double) -> Double
}

public extension UnitCurve {
	/// Retrieve the unit values for the function for the given times
	/// - Parameter t: An array of times 0.0 ... 1.0
	/// - Returns: The unit values of the function for the given times
	@inlinable func values(at t: [Double]) -> [Double] {
		return t.map { self.value(at: $0) }
	}
}
