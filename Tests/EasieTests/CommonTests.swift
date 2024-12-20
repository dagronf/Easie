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

	func testValues() throws {
		// Make sure basic lerp works
		let b1 = Linear()

		// Unit value should map exactly
		stride(from: 0, through: 1, by: 0.01).forEach { value in
			XCTAssertEqual(value, b1.value(at: value))
		}

		let range = -100.0 ... 100.0
		// Verify single convert
		XCTAssertEqual(-100, b1.value(at: 0, in: range))
		XCTAssertEqual(100, b1.value(at: 1, in: range))
		XCTAssertEqual(0, b1.value(at: 0.5, in: range))
		XCTAssertEqual(-50, b1.value(at: 0.25, in: range))
		XCTAssertEqual(50, b1.value(at: 0.75, in: range))

		// Verify multi-convert
		XCTAssertEqual([-100, -50, 0, 50, 100], b1.values(count: 5, in: -100.0 ... 100.0))
	}

	func testValues2() throws {
		let curve = Linear()
		let positions = curve.values(count: 5)
		XCTAssertEqual([0.0, 0.25, 0.5, 0.75, 1.0], positions)
	}

	func testVerifyRawMappedValues() throws {
		// Generate 100 points from 0.0 ... 1.0 and generate the position
		// values for each curve.
		// Compare this to a pre-existing generated

		var results: [String: [Double]] = [:]
		let samples = stride(from: 0, to: 1, by: 0.01).map { $0 }

		var allCurves = AllEasingCurves
		allCurves.append(contentsOf: [
			Linear(values: [0.0, 0.5, 1.0]),
			Linear(values: [0.0, 0.25, 0.25, 1.0]),
			Linear(values: [0.0, 0.125, 0.25, 1.0]),
			Linear(values: [0.0, 1.0, 0.0, 1.0]),
			Linear(values: [0.0, 0.1, 0.5, 0.9, 1.0]),
		])

		allCurves.append(contentsOf: [
			Jump(.jumpStart, steps: 2),
			Jump(.jumpEnd, steps: 4),
			Jump(.jumpNone, steps: 5),
			Jump(.jumpBoth, steps: 3),
		])

		allCurves.append(contentsOf: [
			CubicBezier(x1: 0.1, y1: 0.6, x2: 0.7, y2: 0.2),
			CubicBezier(x1: 0.3, y1: 0.2, x2: 0.2, y2: 1.4),
		])

		for curve in allCurves {
			let points = curve.values(at: samples)
			results[curve.title] = points
		}

		// Uncomment this to regenerate the raw curve results.
//		do {
//			let data = try JSONEncoder().encode(results)
//			try data.write(to: URL(fileURLWithPath: "/tmp/sampledata.json"))
//		}

		let url = try XCTUnwrap(Bundle.module.url(forResource: "sampledata", withExtension: "json"))
		let data = try Data(contentsOf: url)
		let decoded = try JSONDecoder().decode([String: [Double]].self, from: data)

		XCTAssertEqual(decoded.keys.count, results.keys.count)

		for key in decoded.keys {
			let gen = try XCTUnwrap(results[key])
			let orig = try XCTUnwrap(decoded[key])
			XCTAssertEqual(gen.count, orig.count)

			for index in 0 ..< gen.count {
				XCTAssertEqual(gen[index], orig[index], accuracy: 0.00000001)
			}
		}
	}

	func testRangeCurve() throws {
		let curve = Linear(values: [0, 0.5, 1])
		let outputRange = 0.0 ... 600.0

		XCTAssertEqual(0, curve.value(at: 0, in: outputRange), accuracy: 0.0001)
		XCTAssertEqual(150, curve.value(at: 0.25, in: outputRange), accuracy: 0.0001)
		XCTAssertEqual(300, curve.value(at: 0.5, in: outputRange), accuracy: 0.0001)
		XCTAssertEqual(450, curve.value(at: 0.75, in: outputRange), accuracy: 0.0001)
		XCTAssertEqual(600, curve.value(at: 1.0, in: outputRange), accuracy: 0.0001)
	}

#if canImport(CoreGraphics)
	func testSizedCurve() throws {
		let curve = Linear(values: [0, 0.5, 1])
		let sz = CGSize(width: 300, height: 600)

		XCTAssertEqual(0, curve.value(x: 0, in: sz))
		XCTAssertEqual(150, curve.value(x: 75, in: sz))
		XCTAssertEqual(300, curve.value(x: 150, in: sz))
		XCTAssertEqual(450, curve.value(x: 225, in: sz))
		XCTAssertEqual(600, curve.value(x: 300, in: sz))
	}

	func testRectInterpolate() throws {
		let curve = Linear(values: [0, 0.5, 1])
		let r0 = CGRect(x: 0, y: 0, width: 100, height: 100)
		let r1 = CGRect(x: 10, y: 10, width: 80, height: 80)

		
		XCTAssertEqual(r0, curve.value(at: 0, from: r0, through: r1))
		XCTAssertEqual(r1, curve.value(at: 1, from: r0, through: r1))
		XCTAssertEqual(
			CGRect(x: 5, y: 5, width: 90, height: 90),
			curve.value(at: 0.5, from: r0, through: r1)
		)
		XCTAssertEqual(
			CGRect(x: 2.5, y: 2.5, width: 95, height: 95),
			curve.value(at: 0.25, from: r0, through: r1)
		)

	}
#endif
}
