#if canImport(CoreGraphics)

import XCTest

@testable import EasingFunctionsKit
import Bitmap

internal let testResultsContainer = try! TestFilesContainer(named: "EasingFunctionTests")

extension CGContext {
	@inlinable func savingGState(_ block: (CGContext) -> Void) {
		self.saveGState()
		defer { self.restoreGState() }
		block(self)
	}
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

		markdownText += "# easing functions tests\n\n"

		let types: [UnitCurve] = [
			Linear(),
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
			CubicBezier(x1: 0.1, y1: 0.6, x2: 0.7, y2: 0.2),
			CubicBezier(x1: 0.3, y1: 0.2, x2: 0.2, y2: 1.4),
			Jump(.jumpStart, steps: 2),
			Jump(.jumpEnd, steps: 4),
			Jump(.jumpNone, steps: 5),
			Jump(.jumpBoth, steps: 3),
		]

		let font = NSFont(name: "Courier New", size: 24)!

		for type in types {

			// width of the drawing is 300

			let bm = try Bitmap(size: CGSize(width: 600, height: 600), backgroundColor: .black)

			bm.drawRect(CGRect(x: 149.5, y: 149.5, width: 301, height: 301), stroke: .init(color: .white, lineWidth: 1))

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
					NSAttributedString.Key.foregroundColor : NSColor.systemGreen,
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
				let bm = try Bitmap(size: CGSize(width: 300, height: 300), backgroundColor: .black)

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

			let bm = try Bitmap(size: CGSize(width: 300, height: 300), backgroundColor: .black)

			stride(from: 0, through: 299, by: 2).forEach { x in
				let yVal = j.value(at: Double(x) / 300.0)
				bm[x, Int(yVal * 299)] = .red
//				let y = Int(yVal * 299)
//				bm.drawPath(
//					CGPath(ellipseIn: CGRect(x: x - 2, y: y - 2, width: 4, height: 4), transform: nil),
//					fillColor: CGColor(red: 1, green: 0, blue: 0, alpha: 1)
//				)
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
			.foregroundColor: NSColor(white: 0.5, alpha: 1.0),
			.font: NSFont(name: "Courier New", size: 11)!
		]

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
			let p1 = CGPath.build(curve, size: CGSize(width: 150, height: 100), steps: 150)

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

				let pth = CGPath.build(curve, size: CGSize(width: 150, height: 100), steps: 50)
				ctx.savingGState { ctx in
					ctx.addPath(pth)
					ctx.setStrokeColor(CGColor(gray: 1, alpha: 1))
					ctx.setLineWidth(2)
					ctx.strokePath()
				}
			}

			let image = try XCTUnwrap(bm.image)
			let data = try image.representation.png()
			let filename = "gradient-\(curve.title).png"
			let link = try imageStore.store(data, filename: filename)

			markdownText += "<img src='\(link)' />&nbsp;"
		}
	}
}

#endif
