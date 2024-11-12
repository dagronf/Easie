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

// MARK: - Unit Value

public extension UnitCurve {
	/// Retrieve the unit values for the function for the given times
	/// - Parameter t: An array of times 0.0 ... 1.0
	/// - Returns: The unit values of the function for the given times
	@inlinable func values(at t: [Double]) -> [Double] {
		return t.map { self.value(at: $0) }
	}

	/// Return evenly spaced curve values
	/// - Parameter count: The number of evenly spaced steps (must be > 1)
	/// - Returns: An array of evenly spaced unit curve values
	func values(count: Int) -> [Double] {
		assert(count > 1)
		let dx = 1.0 / Double(count - 1)
		return stride(from: 0.0, through: 1.0, by: dx)
			.map { self.value(at: $0) }
	}
}

// MARK: - Value

public extension UnitCurve {
	/// Retrive the curve value between two values
	/// - Parameters:
	///   - v0: The first value
	///   - v1: The second value
	///   - t: The time value, 0.0 ... 1.0
	/// - Returns: The interpolated value between the two values
	func value(_ v0: Double, _ v1: Double, at t: Double) -> Double {
		let t = t.unitClamped()
		return lerp(v0, v1, t: self.value(at: t))
	}

	/// Retrieve curve values between two values
	/// - Parameters:
	///   - v0: The first value
	///   - v1: The second value
	///   - t: An array of time values, 0.0 ... 1.0
	/// - Returns: The interpolated values between the two points
	func values(_ v0: Double, _ v1: Double, at t: [Double]) -> [Double] {
		assert(t.count > 0)
		return t.map { self.value(v0, v1, at: $0) }
	}

	/// Return evenly spaced curve values between two values
	/// - Parameters:
	///   - v0: first value
	///   - v1: second value
	///   - count: The number of steps (must be > 1)
	/// - Returns: An array of evenly spaced curve positions
	func values(_ v0: Double, _ v1: Double, count: Int) -> [Double] {
		assert(count > 1)
		return self.values(count: count)
			.map { lerp(v0, v1, t: $0) }
	}
}

// MARK: - Ranges

public extension UnitCurve {
	/// Retrive the curve value between two values
	/// - Parameters:
	///   - range: The value range
	///   - t: The time value, 0.0 ... 1.0
	/// - Returns: The interpolated value between the two points
	@inlinable @inline(__always)
	func value(_ range: ClosedRange<Double>, at t: Double) -> Double {
		self.value(range.lowerBound, range.upperBound, at: t)
	}

	/// Retrive the curve value within a range
	/// - Parameters:
	///   - range: The value range
	///   - t: An array of time value, 0.0 ... 1.0
	/// - Returns: The interpolated value between the two values
	@inlinable @inline(__always)
	func values(_ range: ClosedRange<Double>, at t: [Double]) -> [Double] {
		self.values(range.lowerBound, range.upperBound, at: t)
	}

	/// Retrieve curve values within a range
	/// - Parameters:
	///   - range: The value range
	///   - count: The number of steps (must be > 1)
	/// - Returns: The interpolated value between the two values
	@inlinable @inline(__always)
	func values(_ range: ClosedRange<Double>, count: Int) -> [Double] {
		self.values(range.lowerBound, range.upperBound, count: count)
	}
}
