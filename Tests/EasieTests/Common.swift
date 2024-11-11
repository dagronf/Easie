@testable import Easie

#if os(macOS)
import AppKit.NSFont
typealias Font = NSFont
#elseif os(iOS) || os(tvOS) || os(visionOS) || os(watchOS)
import UIKit.UIFont
typealias Font = UIFont
#endif

let AllEasingCurves: [UnitCurve] = [
	EaseIn(type: .sine),
	EaseIn(type: .cubic),
	EaseIn(type: .quint),
	EaseIn(type: .circ),
	EaseIn(type: .quad),
	EaseIn(type: .quart),
	EaseIn(type: .expo),
	EaseOut(type: .sine),
	EaseOut(type: .cubic),
	EaseOut(type: .quint),
	EaseOut(type: .circ),
	EaseOut(type: .quad),
	EaseOut(type: .quart),
	EaseOut(type: .expo),
	EaseInEaseOut(type: .sine),
	EaseInEaseOut(type: .cubic),
	EaseInEaseOut(type: .quint),
	EaseInEaseOut(type: .circ),
	EaseInEaseOut(type: .quad),
	EaseInEaseOut(type: .quart),
	EaseInEaseOut(type: .expo),
	EaseInBack(),
	EaseOutBack(),
	EaseInEaseOutBack(),
	EaseInBounce(),
	EaseOutBounce(),
	EaseInEaseOutBounce(),
	EaseInElastic(),
	EaseOutElastic(),
	EaseInEaseOutElastic(),
]

let AllEasingCurvesBack: [UnitCurve] = [
	EaseInBack(),
	EaseOutBack(),
	EaseInEaseOutBack(),
]

let AllBasicEasingCurves: [UnitCurve] = [
	EaseIn(type: .sine),
	EaseIn(type: .cubic),
	EaseIn(type: .quint),
	EaseIn(type: .circ),
	EaseIn(type: .quad),
	EaseIn(type: .quart),
	EaseIn(type: .expo),
	EaseOut(type: .sine),
	EaseOut(type: .cubic),
	EaseOut(type: .quint),
	EaseOut(type: .circ),
	EaseOut(type: .quad),
	EaseOut(type: .quart),
	EaseOut(type: .expo),
	EaseInEaseOut(type: .sine),
	EaseInEaseOut(type: .cubic),
	EaseInEaseOut(type: .quint),
	EaseInEaseOut(type: .circ),
	EaseInEaseOut(type: .quad),
	EaseInEaseOut(type: .quart),
	EaseInEaseOut(type: .expo),
]

let AllEasingCurvesBounce: [UnitCurve] = [
	EaseInBounce(),
	EaseOutBounce(),
	EaseInEaseOutBounce(),
]

let AllEasingCurvesElastic: [UnitCurve] = [
	EaseInElastic(),
	EaseOutElastic(),
	EaseInEaseOutElastic(),
]
