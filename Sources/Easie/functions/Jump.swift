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

/// Divides the domain of output values in equidistant steps
///
/// See: [https://developer.mozilla.org](https://developer.mozilla.org/en-US/docs/Web/CSS/easing-function#steps_easing_function)
public struct Jump: UnitCurve, Sendable {

	/// The type of jump function to apply
	public enum JumpType: Sendable, CaseIterable {
		/// Jump up to the first step at the t=0.0 point, with the final step at t=1.0
		case jumpStart
		/// Jump up to the first step at the end of the first step
		case jumpEnd
		/// Jump up to the first step at the end of the first step, with the final step at 1.0
		case jumpNone
		/// Jump up to the first step at t=0 with the final step at 1.0
		case jumpBoth
	}

	private let steps: Int
	private let jumpType: JumpType
	private let chunkSize: Double
	
	/// The title for the easing function
	public var title: String { "jump-\(self.jumpType)-\(self.steps)" }

	/// Create a step easing function
	/// - Parameters:
	///   - jumpType: The jump function
	///   - steps: The number of steps
	public init(_ jumpType: JumpType, steps: Int) {
		assert(steps >= 2)
		self.jumpType = jumpType
		self.steps = steps
		self.chunkSize = 1.0 / Double(self.steps)
	}

	/// Retrieve the unit value for the function for the given time
	/// - Parameter t: The time value, 0.0 ... 1.0
	/// - Returns: The unit value of the function at the given time
	public func value(at t: Double) -> Double {
		let t = t.unitClamped()

		// Which chunk does the value fall in?
		let which = (t / chunkSize).rounded(.towardZero)

		switch jumpType {
		case .jumpStart:
			return min(1, self.chunkSize + (which * self.chunkSize))
		case .jumpEnd:
			return min(1, which * self.chunkSize)
		case .jumpNone:
			let vDiv = 1.0 / Double(self.steps - 1)
			return min(1, which * vDiv)
		case .jumpBoth:
			let vDiv = 1.0 / Double(self.steps + 1)
			return min(1, vDiv + (which * vDiv))
		}
	}
}
