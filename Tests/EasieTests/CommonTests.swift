import XCTest
@testable import Easie

final class CommonTests: XCTestCase {
	func testStartEndEasingCheck() throws {
		/// Make sure that the curves always start at 0.0 and end at 1.0
		AllEasingCurves.forEach { curve in
			XCTAssertEqual(0, curve.value(at: 0), accuracy: 0.000001, "curve type = \(curve.title)")
			XCTAssertEqual(1, curve.value(at: 1), accuracy: 0.000001, "curve type = \(curve.title)")
		}
	}
}
