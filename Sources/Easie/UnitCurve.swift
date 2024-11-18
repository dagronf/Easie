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

// MARK: - Mapping to a closed range

public extension UnitCurve {
	/// Retrive the curve value between two values
	/// - Parameters:
	///   - t: The time value, 0.0 ... 1.0
	///   - range: The value range
	/// - Returns: The interpolated value between the two points
	@inlinable @inline(__always)
	func value(at t: Double, outputRange: ClosedRange<Double>) -> Double {
		lerp(outputRange.lowerBound, outputRange.upperBound, t: self.value(at: t.unitClamped()))
	}

	/// Retrive the curve value within a range
	/// - Parameters:
	///   - t: An array of time value, 0.0 ... 1.0
	///   - outputRange: The output value range
	/// - Returns: The interpolated value between the two values
	@inlinable @inline(__always)
	func values(at t: [Double], outputRange: ClosedRange<Double>) -> [Double] {
		assert(t.count > 0)
		return t.map { self.value(at: $0, outputRange: outputRange) }
	}

	/// Retrieve curve values within a range
	/// - Parameters:
	///   - range: The value range
	///   - count: The number of steps (must be > 1)
	/// - Returns: The interpolated value between the two values
	@inlinable @inline(__always)
	func values(_ range: ClosedRange<Double>, count: Int) -> [Double] {
		assert(count > 1)
		return self.values(count: count)
			.map { lerp(range.lowerBound, range.upperBound, t: $0) }
	}
}

// MARK: - Mapping to a size

public extension UnitCurve {
	/// Return the position value for the curve at t
	/// - Parameters:
	///   - x: The t value (0 ... size.width)
	///   - size: The curve size
	/// - Returns: A position value (0 ... size.height)
	@inlinable @inline(__always)
	func value(at x: Double, in size: CGSize) -> Double {
		let x = max(0, min(size.width, x))
		let t = x / size.width
		return lerp(0, size.height, t: self.value(at: t))
	}

	/// Return the positions value for the curve at t
	/// - Parameters:
	///   - t: The t values (0 ... size.width)
	///   - size: The curve size
	/// - Returns:Position values (0 ... size.height)
	@inlinable func values(at t: [Double], in size: CGSize) -> [Double] {
		t.map { self.value(at: $0, in: size) }
	}
}

// MARK: - Mapping to a rect

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
