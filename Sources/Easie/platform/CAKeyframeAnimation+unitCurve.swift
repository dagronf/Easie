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

#if canImport(QuartzCore) && !os(watchOS)

import Foundation
import QuartzCore

public extension CAKeyframeAnimation {
	/// Create a keyframe animation between two values
	/// - Parameters:
	///   - keyPath: The key path
	///   - curve: The curve
	///   - from: The from value
	///   - through: The to value
	///   - keyframeCount: The number of key frames to include
	/// - Returns: A keyframe animation
	static func animation(
		_ keyPath: String?,
		curve: UnitCurve,
		from: Double,
		through: Double,
		keyframeCount: Int = 60
	) -> CAKeyframeAnimation {
		let a = CAKeyframeAnimation(keyPath: keyPath)
		a.values = curve.values(from, through, count: keyframeCount)
			.map { NSNumber(value: $0) }
		return a
	}

	/// Create a keyframe animation between two points
	/// - Parameters:
	///   - keyPath: The key path
	///   - curve: The curve
	///   - from: The from point
	///   - through: The to point
	///   - keyframeCount: The number of key frames to add
	/// - Returns: A keyframe animation
	static func animation(
		_ keyPath: String?,
		curve: UnitCurve,
		from: CGPoint,
		through: CGPoint,
		keyframeCount: Int = 60
	) -> CAKeyframeAnimation {
		let a = CAKeyframeAnimation(keyPath: keyPath)
		a.values = curve.values(from, through, count: keyframeCount)
			.map { NSValue(point: $0) }
		return a
	}

	/// Create a keyframe animation between two sizes
	/// - Parameters:
	///   - keyPath: The key path
	///   - curve: The curve
	///   - from: The from size
	///   - through: The to size
	///   - keyframeCount: The number of key frames to add
	/// - Returns: A keyframe animation
	static func animation(
		_ keyPath: String?,
		curve: UnitCurve,
		from: CGSize,
		through: CGSize,
		keyframeCount: Int = 60
	) -> CAKeyframeAnimation {
		let a = CAKeyframeAnimation(keyPath: keyPath)
		a.values = curve.values(from, through, count: keyframeCount)
			.map { NSValue(size: $0) }
		return a
	}
}

#endif
