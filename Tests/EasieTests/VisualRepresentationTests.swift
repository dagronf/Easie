#if canImport(CoreGraphics)

import XCTest

@testable import Easie
import Bitmap

internal let testResultsContainer = try! TestFilesContainer(named: "EasingFunctionTests")

extension CGContext {
	@inlinable func savingGState(_ block: (CGContext) -> Void) {
		self.saveGState()
		defer { self.restoreGState() }
		block(self)
	}
}

func allTestCurves() -> [UnitCurve] {
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
	return allCurves
}

final class EasingFunctionsKitTests: XCTestCase {

	func testExample() throws {

		let outputFolder = try! testResultsContainer.subfolder(with: "bitmaps")
		let imagesFolder = try! outputFolder.subfolder(with: "images")
		let imageStore = ImageOutput(imagesFolder)
		var markdownText = ""

		defer {
			try! outputFolder.write(markdownText, to: "function-bitmaps.md", encoding: .utf8)
		}

		markdownText += "# Easing functions tests\n\n"

		let font = Font.systemFont(ofSize: 24)

		for type in allTestCurves() {

			// width of the drawing is 300

			let bm = try Bitmap(size: CGSize(width: 600, height: 600), backgroundColor: CGColor(gray: 0, alpha: 1))

			bm.drawRect(CGRect(x: 149.5, y: 149.5, width: 301, height: 301), stroke: .init(color: CGColor(gray: 1, alpha: 1), lineWidth: 1))

			stride(from: 0, to: 300, by: 2).forEach { i in
				let frac = Double(i) / 300.0
				let yVal = type.value(at: frac) * 300.0

				let x = 150 + i
				let y = 150 + Int(yVal)

				//bm[x, y] = .red

				bm.drawPath(
					CGPath(ellipseIn: CGRect(x: x - 2, y: y - 2, width: 4, height: 4), transform: nil),
					fillColor: CGColor(red: 1, green: 0, blue: 0, alpha: 1)
				)

				let str = NSAttributedString(string: type.title, attributes: [
					NSAttributedString.Key.font : font,
					NSAttributedString.Key.foregroundColor : CGColor(srgbRed: 0, green: 1, blue: 0, alpha: 1)
				])

				bm.drawText(str, position: CGPoint(x: 10, y: 10))
			}

			let image = try XCTUnwrap(bm.image)
			let data = try image.representation.png()
			let filename = "\(type.title).png"
			let link = try imageStore.store(data, filename: filename)
			markdownText += "## \(type.title)\n\n"
			markdownText += "<img src='\(link)' width='300' />\n\n"
		}
	}

	func testJump() throws {

		let outputFolder = try! testResultsContainer.subfolder(with: "steps")
		let imagesFolder = try! outputFolder.subfolder(with: "images")
		let imageStore = ImageOutput(imagesFolder)
		var markdownText = ""

		defer {
			try! outputFolder.write(markdownText, to: "steps.md", encoding: .utf8)
		}

		markdownText += "# Jump easing functions\n\n"

		for jumpType in Jump.JumpType.allCases {
			markdownText += "## \(jumpType)\n\n"
			try (2 ... 6).forEach { stepCount in
				let bm = try Bitmap(size: CGSize(width: 300, height: 300), backgroundColor: CGColor(gray: 0, alpha: 1))

				let j = Jump(jumpType, steps: stepCount)
				stride(from: 0, through: 299, by: 2).forEach { x in
					let yVal = j.value(at: Double(x) / 300.0)
					//bm[x, Int(yVal * 299)] = .red
					let y = Int(yVal * 299)

					bm.drawPath(
						CGPath(ellipseIn: CGRect(x: x - 2, y: y - 2, width: 4, height: 4), transform: nil),
						fillColor: CGColor(red: 1, green: 0, blue: 0, alpha: 1)
					)
				}

				let image = try XCTUnwrap(bm.image)
				let data = try image.representation.png()
				let filename = "\(j.title).png"
				let link = try imageStore.store(data, filename: filename)

				markdownText += "<img src='\(link)' width='150' />&nbsp;"
			}

			markdownText += "\n\n"
		}
	}

	func testLinear() throws {

		let outputFolder = try! testResultsContainer.subfolder(with: "linear")
		let imagesFolder = try! outputFolder.subfolder(with: "images")
		let imageStore = ImageOutput(imagesFolder)
		var markdownText = ""

		defer {
			try! outputFolder.write(markdownText, to: "linear.md", encoding: .utf8)
		}

		let linears: [UnitCurve] = [
			Linear(values: [0.0, 0.5, 1.0]),
			Linear(values: [0.0, 0.25, 0.25, 1.0]),
			Linear(values: [0.0, 0.125, 0.25, 1.0]),
			Linear(values: [0.0, 1.0, 0.0, 1.0]),
			Linear(values: [0.0, 0.1, 0.5, 0.9, 1.0]),
		]

		for j in linears {

			let bm = try Bitmap(size: CGSize(width: 300, height: 300), backgroundColor: CGColor(gray: 0, alpha: 1))

			stride(from: 0, through: 299, by: 2).forEach { x in
				let yVal = j.value(at: Double(x) / 300.0)
				bm[x, Int(yVal * 299)] = .red
			}

			let image = try XCTUnwrap(bm.image)
			let data = try image.representation.png()
			let filename = "\(j.title).png"
			let link = try imageStore.store(data, filename: filename)

			markdownText += "<img src='\(link)' width='150' />&nbsp;"
		}
	}

	func testBuildPath() throws {

		let outputFolder = try! testResultsContainer.subfolder(with: "path-generation")
		let imagesFolder = try! outputFolder.subfolder(with: "images")
		let imageStore = ImageOutput(imagesFolder)
		var markdownText = ""

		defer {
			try! outputFolder.write(markdownText, to: "path-generation.md", encoding: .utf8)
		}

		let fontDetails: [NSAttributedString.Key: Any] = [
			.foregroundColor: CGColor(gray: 0.5, alpha: 1),
			.font: Font.systemFont(ofSize: 11)
		]

		for curve in allTestCurves() {
			let p1 = curve.cgPath(size: CGSize(width: 150, height: 100), steps: 150)

			let bm = try Bitmap(size: CGSize(width: 200, height: 180)) { ctx in

				ctx.savingGState { ctx in
					ctx.addRect(CGRect(x: 0, y: 0, width: 200, height: 180))
					ctx.setFillColor(CGColor(gray: 0.2, alpha: 0.1))
					ctx.fillPath()
				}

				ctx.savingGState { ctx in
					ctx.addPath(CGPath(rect: CGRect(x: 25, y: 40, width: 150, height: 100), transform: nil))
					ctx.setStrokeColor(CGColor(gray: 0.5, alpha: 1))
					ctx.setLineWidth(1)
					ctx.setLineDash(phase: 0, lengths: [2, 2])
					ctx.strokePath()
				}

				ctx.savingGState { ctx in
					let attributedString = NSAttributedString(string: curve.title, attributes: fontDetails)
					let line = CTLineCreateWithAttributedString(attributedString)
					ctx.translateBy(x: 10, y: 10)
					CTLineDraw(line, ctx)
				}

				ctx.savingGState { ctx in
					ctx.translateBy(x: 25, y: 40)
					ctx.setStrokeColor(CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 1))
					ctx.setLineWidth(3)
					ctx.addPath(p1)
					ctx.strokePath()
				}
			}

			let image = try XCTUnwrap(bm.image)
			let data = try image.representation.png()
			let filename = "path-\(curve.title).png"
			let link = try imageStore.store(data, filename: filename)

			markdownText += "<img src='\(link)' />&nbsp;"
		}
	}

	func testGradient() throws {

		let outputFolder = try! testResultsContainer.subfolder(with: "gradient-generation")
		let imagesFolder = try! outputFolder.subfolder(with: "images")
		let imageStore = ImageOutput(imagesFolder)
		var markdownText = ""

		defer {
			try! outputFolder.write(markdownText, to: "gradient-generation.md", encoding: .utf8)
		}

		let fontDetails: [NSAttributedString.Key: Any] = [
			.foregroundColor: CGColor(gray: 0, alpha: 1),
			.font: Font.systemFont(ofSize: 11)
		]

		for curve in allTestCurves() {

			let gradient = try CGGradient.build(
				from: CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 1),
				to: CGColor(srgbRed: 0, green: 0, blue: 1, alpha: 1),
				curve: curve,
				steps: 30
			)

			let bm = try Bitmap(size: CGSize(width: 150, height: 100)) { ctx in
				ctx.drawLinearGradient(
					gradient,
					start: CGPoint(x: 0, y: 0),
					end: CGPoint(x: 150, y: 0),
					options: [.drawsAfterEndLocation, .drawsBeforeStartLocation]
				)

				let pth = curve.cgPath(size: CGSize(width: 150, height: 100), steps: 50)
				ctx.savingGState { ctx in
					ctx.addPath(pth)
					ctx.setStrokeColor(CGColor(gray: 1, alpha: 1))
					ctx.setLineWidth(2)
					ctx.strokePath()
				}

				ctx.savingGState { ctx in
					let attributedString = NSAttributedString(string: curve.title, attributes: fontDetails)
					let line = CTLineCreateWithAttributedString(attributedString)
					ctx.translateBy(x: 5, y: 5)
					CTLineDraw(line, ctx)
				}

			}

			let image = try XCTUnwrap(bm.image)
			let data = try image.representation.png()
			let filename = "gradient-\(curve.title).png"
			let link = try imageStore.store(data, filename: filename)

			markdownText += "<img src='\(link)' />&nbsp;"
		}
	}

	func testCGPointInterpolation() throws {
		let curve = Linear()
		XCTAssertEqual(
			CGPoint(x: -100, y: 100),
			curve.value(at: 0.0, from: CGPoint(x: -100, y: 100), through: CGPoint(x: 100, y: -100))
		)
		XCTAssertEqual(
			CGPoint(x: 100, y: -100),
			curve.value(at: 1.0, from: CGPoint(x: -100, y: 100), through: CGPoint(x: 100, y: -100))
		)
		XCTAssertEqual(
			CGPoint(x: 0, y: 0),
			curve.value(at: 0.5, from: CGPoint(x: -100, y: 100), through: CGPoint(x: 100, y: -100))
		)
		XCTAssertEqual(
			CGPoint(x: -50, y: 50),
			curve.value(at: 0.25, from: CGPoint(x: -100, y: 100), through: CGPoint(x: 100, y: -100))
		)
	}

	func testCGPointInterpolations() throws {
		let curve = Linear()
		let p0 = CGPoint(x: -100, y: 100)
		let p1 = CGPoint(x: 100, y: -100)

		let pts = curve.values(count: 5, from: p0, through: p1)
		XCTAssertEqual(5, pts.count)
		XCTAssertEqual(pts[0], CGPoint(x: -100, y: 100))
		XCTAssertEqual(pts[1], CGPoint(x: -50, y: 50))
		XCTAssertEqual(pts[2], CGPoint(x: 0, y: 0))
		XCTAssertEqual(pts[3], CGPoint(x: 50, y: -50))
		XCTAssertEqual(pts[4], CGPoint(x: 100, y: -100))

		XCTAssertEqual(
			CGPoint(x: -100, y: 100),
			curve.value(at: 0.0, from: p0, through: p1)
		)
		XCTAssertEqual(
			CGPoint(x: 100, y: -100),
			curve.value(at: 1.0, from: p0, through: p1)
		)
		XCTAssertEqual(
			CGPoint(x: 0, y: 0),
			curve.value(at: 0.5, from: p0, through: p1)
		)
		XCTAssertEqual(
			CGPoint(x: -50, y: 50),
			curve.value(at: 0.25, from: p0, through: p1)
		)
	}

	func testLerp() throws {

		let outputFolder = try! testResultsContainer.subfolder(with: "lerp-tests")
		let imagesFolder = try! outputFolder.subfolder(with: "images")
		let imageStore = ImageOutput(imagesFolder)
		var markdownText = ""

		defer {
			try! outputFolder.write(markdownText, to: "lerp-tests.md", encoding: .utf8)
		}

		markdownText += "|  name  |  curve  |  lerp  |\n"
		markdownText += "|--------|---------|--------|\n"

		for curve in allTestCurves() {

			markdownText += "| \(curve.title) "

			let rect = CGRect(x: 0, y: 0, width: 150, height: 150)
			let sz = rect.size

			let bm2 = try Bitmap(size: sz) { ctx in
				ctx.savingGState { ctx in
					ctx.setFillColor(CGColor(gray: 0.9, alpha: 1))
					ctx.fill([rect])
					ctx.setStrokeColor(CGColor(gray: 0.4, alpha: 1))
					ctx.setLineWidth(0.5)
					ctx.stroke(rect.insetBy(dx: 0.5, dy: 0.5))

					ctx.setStrokeColor(CGColor(gray: 0.4, alpha: 1))
					ctx.setLineWidth(0.5)
					ctx.stroke(CGRect(x: 24.5, y: 24.5, width: 101, height: 101))
				}

				ctx.savingGState { ctx in
					let pth = curve.cgPath(size: CGSize(width: 100, height: 100), steps: 25)
					ctx.translateBy(x: 25, y: 25)
					ctx.addPath(pth)
					ctx.setStrokeColor(CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 1))
					ctx.strokePath()
				}
			}

			let image2 = try XCTUnwrap(bm2.image)
			let data2 = try image2.representation.png()
			let filename2 = "lerp-\(curve.title)-curve.png"
			let link2 = try imageStore.store(data2, filename: filename2)

			markdownText += "| <img src='\(link2)' width='150' /> "

			let v = curve.values(count: 25, from: CGPoint(x: 0, y: 20), through: CGPoint(x: 100, y: 79))

			let bm = try Bitmap(size: sz) { ctx in
				ctx.savingGState { ctx in
					ctx.setFillColor(CGColor(gray: 0.9, alpha: 1))
					ctx.fill([rect])
					ctx.setStrokeColor(CGColor(gray: 0.4, alpha: 1))
					ctx.setLineWidth(0.5)
					ctx.stroke(rect.insetBy(dx: 0.5, dy: 0.5))

					ctx.setStrokeColor(CGColor(gray: 0.4, alpha: 1))
					ctx.setLineWidth(0.5)
					ctx.stroke(CGRect(x: 24.5, y: 24.5, width: 101, height: 101))
				}

				ctx.savingGState { ctx in
					v.forEach {
						let pos = CGRect(x: 25 +  $0.x - 2, y: 25 + $0.y - 2, width: 4, height: 4)
						let t = $0.x / (100 - $0.x)
						ctx.setFillColor(CGColor(srgbRed: t, green: 0, blue: 1 - t, alpha: 1))
						ctx.addPath(CGPath(ellipseIn: pos, transform: nil))
						ctx.fillPath()
					}
				}
			}

			let image = try XCTUnwrap(bm.image)
			let data = try image.representation.png()
			let filename = "lerp-\(curve.title).png"
			let link = try imageStore.store(data, filename: filename)

			markdownText += "| <img src='\(link)' width='150' /> |\n"
		}
	}

	func testInterpolatedRect() throws {
		let outputFolder = try! testResultsContainer.subfolder(with: "rect-interpolation")
		let imagesFolder = try! outputFolder.subfolder(with: "images")
		let imageStore = ImageOutput(imagesFolder)
		var markdownText = ""

		defer {
			try! outputFolder.write(markdownText, to: "rect-interpolation.md", encoding: .utf8)
		}

		markdownText += "|  name  | curve |  rectinterp  |\n"
		markdownText += "|--------|-------|--------------|\n"

		let r0 = CGRect(x: 0, y: 0, width: 200, height: 200)
		let r1 = CGRect(x: 120, y: 120, width: 40, height: 40)

		let c0 = CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 0.8)
		let c1 = CGColor(srgbRed: 0, green: 0, blue: 1, alpha: 0.8)

		let steps = 30
		let rect = CGRect(x: 0, y: 0, width: 200, height: 200)
		let sz = rect.size

		for curve in allTestCurves() {

			markdownText += "| \(curve.title) "

			do {
				let bm2 = try Bitmap(size: sz) { ctx in
					ctx.savingGState { ctx in
						ctx.setFillColor(CGColor(gray: 0.9, alpha: 1))
						ctx.fill([rect])
						ctx.setStrokeColor(CGColor(gray: 0.4, alpha: 1))
						ctx.setLineWidth(0.5)
						ctx.stroke(rect.insetBy(dx: 0.5, dy: 0.5))

						ctx.setStrokeColor(CGColor(gray: 0.4, alpha: 1))
						ctx.setLineWidth(0.5)
						ctx.stroke(CGRect(x: 24.5, y: 24.5, width: 151, height: 151))
					}

					ctx.savingGState { ctx in
						let pth = curve.cgPath(size: CGSize(width: 150, height: 150), steps: 25)
						ctx.translateBy(x: 25, y: 25)
						ctx.addPath(pth)
						ctx.setStrokeColor(CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 1))
						ctx.strokePath()
					}
				}

				let image2 = try XCTUnwrap(bm2.image)
				let data2 = try image2.representation.png()
				let filename2 = "rectinterpolate-\(curve.title)-curve.png"
				let link2 = try imageStore.store(data2, filename: filename2)

				markdownText += "| <img src='\(link2)' width='150' /> "
			}

			let v = equallySpacedUnitValues(steps)

			let bm = try Bitmap(size: sz) { ctx in
				(0 ..< steps).forEach { index in
					let t = v[index]
					let v = curve.value(at: t, from: r0, through: r1)
					ctx.setStrokeColor((try? curve.value(at: t, from: c0, through: c1)) ?? CGColor(gray: 0, alpha: 1))
					ctx.setLineWidth(0.5)
					ctx.stroke(v)
				}
			}

			let image = try XCTUnwrap(bm.image)
			let data = try image.representation.png()
			let filename = "interpolation-\(curve.title).png"
			let link = try imageStore.store(data, filename: filename)

			markdownText += "| <img src='\(link)' width='150' /> |\n"
		}
	}
}

#endif
