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
		return equallySpacedUnitValues(count)
			.map { self.value(at: $0) }
	}
}

// MARK: - Mapping between two values

public extension UnitCurve {
	/// Retrieve a position value for the function for the given time
	/// - Parameters:
	///   - t: The t value
	///   - v0: first value
	///   - v1: second value
	/// - Returns: The mapped position value
	@inlinable func value(at t: Double, from v0: Double, through v1: Double) -> Double {
		lerp(v0, v1, t: self.value(at: t.unitClamped()))
	}

	/// Retrieve position values for the function for the given times
	/// - Parameters:
	///   - t: An array of t values to map
	///   - v0: first value
	///   - v1: second value
	/// - Returns: The mapped position values
	@inlinable func values(at t: [Double], from v0: Double, through v1: Double) -> [Double] {
		self.values(at: t).map { lerp(v0, v1, t: $0) }
	}

	/// Retrieve equally spaced curve values between two values
	/// - Parameters:
	///   - count: The number of steps (must be > 1)
	///   - v0: first value
	///   - v1: second value
	/// - Returns: The interpolated values between the two values
	@inlinable func values(count: Int, from v0: Double, through v1: Double) -> [Double] {
		self.values(count: count).map { lerp(v0, v1, t: $0) }
	}
}

// MARK: - Mapping to a closed range

public extension UnitCurve {
	/// Returns the curve value between a closed range for a given time
	/// - Parameters:
	///   - t: The time value, 0.0 ... 1.0
	///   - outputRange: The value range
	/// - Returns: The interpolated value between the two points
	@inlinable func value(at t: Double, in outputRange: ClosedRange<Double>) -> Double {
		self.value(at: t, from: outputRange.lowerBound, through: outputRange.upperBound)
	}

	/// Returns curve values between a closed range for given times
	/// - Parameters:
	///   - t: An array of time values, 0.0 ... 1.0
	///   - outputRange: The output value range
	/// - Returns: The interpolated value between the two values
	@inlinable func values(at t: [Double], in outputRange: ClosedRange<Double>) -> [Double] {
		self.values(at: t, from: outputRange.lowerBound, through: outputRange.upperBound)
	}

	/// Returns curve values between a closed range for given times
	/// - Parameters:
	///   - count: The number of steps (must be > 1)
	///   - range: The output value range
	/// - Returns: The interpolated value between the two values
	@inlinable func values(count: Int, in range: ClosedRange<Double>) -> [Double] {
		self.values(count: count, from: range.lowerBound, through: range.upperBound)
	}
}
