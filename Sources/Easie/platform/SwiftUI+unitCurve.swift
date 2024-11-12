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

#if canImport(SwiftUI)
import SwiftUI

/// A SwiftUI `Path` containing a unit easing curve
@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
public extension Path {
	/// Create a path using a unit cirve
	/// - Parameters:
	///   - curve: The unit curve definition
	///   - size: The path size
	///   - steps: The number of steps to use when approximating the curve
	init(_ curve: Easie.UnitCurve, size: CGSize, steps: Int) {
		let path = curve.cgPath(size: size, steps: steps, isFlipped: true)
		self.init(path)
	}
}

/// A SwiftUI `Shape` containing a unit easing curve
@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
public struct EasingCurve: Shape {
	let curve: Easie.UnitCurve
	let steps: Int

	/// Create a Shape with a unit curve
	/// - Parameters:
	///   - curve: The unit curve definition
	///   - steps: The number of steps to use when approximating the curve
	public init(curve: Easie.UnitCurve, steps: Int) {
		self.curve = curve
		self.steps = steps
	}

	/// Describes this shape as a path within a rectangular frame of reference.
	public func path(in rect: CGRect) -> Path {
		Path(self.curve.cgPath(size: rect.size, steps: self.steps, isFlipped: true))
	}
}

#endif
