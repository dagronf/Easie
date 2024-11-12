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

/// A curve defined by linear interpolation
public struct Linear: UnitCurve {
	/// The interpolation points
	public let progressValues: [Double]
	/// The number of interpolation points
	public let count: Int

	/// Create a direct transfer function (position == t)
	public init() {
		self.progressValues = []
		self.count = 0
	}

	/// Create a linear interpolation curve
	public init(values: [Double]) {
		assert(values.count > 2)
		assert(values[0].isEqualTo(0, precision: 8))
		assert(values[values.count - 1].isEqualTo(1, precision: 8))

		self.progressValues = values
		self.count = values.count
	}

	/// The title for the easing function
	public var title: String {
		if progressValues.count == 0 { return "linear" }
		let str = progressValues.map { String($0) }.joined(separator: ",")
		return "linear(\(str))"
	}

	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	public func value(at t: Double) -> Double {
		// If there's less than 3 values just interpret as linear
		if self.progressValues.count < 3 { return t }

		let t = t.unitClamped()
		if t.isEqualTo(0.0, precision: 8) {
			// Just return the first value (which will exist because we've checked earlier, hence the force unwrap)
			return self.progressValues.first!
		}
		else if t.isEqualTo(1.0, precision: 8) {
			// Just return the last value (which will exist because we've checked earlier, hence the force unwrap)
			return self.progressValues.last!
		}

		let divisor = 1.0 / Double(self.count - 1)
		let which = Int(t / divisor)

		let x1 = Double(which) * divisor
		let x2 = Double(which + 1) * divisor
		let y1 = self.progressValues[which]
		let y2 = self.progressValues[which + 1]

		// The new t value is the current t value fractionally between x1 and x2
		let newT = (t - x1) / (x2 - x1)

		// let xVal = x1 + ((x2 - x1) * newT)
		let yVal = y1 + ((y2 - y1) * newT)

		return yVal
	}
}
