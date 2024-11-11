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

class TestFilesContainer {
	// Note:  DateFormatter is thread safe
	// See https://developer.apple.com/documentation/foundation/dateformatter#1680059
	private static let iso8601Formatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX ISO8601
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HHmmssZ"
		return dateFormatter
	}()

	private let root: Subfolder
	var rootFolder: URL { self.root.folder }
	init(named name: String) throws {
		let baseURL = FileManager.default.temporaryDirectory.appendingPathComponent(name)

		let url = baseURL.appendingPathComponent(Self.iso8601Formatter.string(from: Date()))
		try? FileManager.default.removeItem(at: url)
		try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
		self.root = Subfolder(url)
		Swift.print("TestContainer(\(name) - Generated files at: \(url)")

		let latest = baseURL.appendingPathComponent("_latest")
		try? FileManager.default.removeItem(at: latest)
		try! FileManager.default.createSymbolicLink(at: latest, withDestinationURL: url)
	}

	func subfolder(with components: String...) throws -> Subfolder {
		var subfolder = self.rootFolder
		components.forEach { subfolder.appendPathComponent($0) }
		try FileManager.default.createDirectory(at: subfolder, withIntermediateDirectories: true)
		return Subfolder(subfolder)
	}

	class Subfolder {
		let folder: URL

		init(_ parent: URL) {
			self.folder = parent
		}
		init(named name: String, parent: URL) throws {
			let subf = parent.appendingPathComponent(name)
			try FileManager.default.createDirectory(at: subf, withIntermediateDirectories: true)
			self.folder = subf
		}

		func subfolder(with components: String...) throws -> Subfolder {
			var subfolder = self.folder
			components.forEach { subfolder.appendPathComponent($0) }
			try FileManager.default.createDirectory(at: subfolder, withIntermediateDirectories: true)
			return Subfolder(subfolder)
		}

		@discardableResult func write(
			_ data: Data,
			to file: String
		) throws -> URL {
			let tempURL = self.folder.appendingPathComponent(file)
			try data.write(to: tempURL)
			return tempURL
		}

		@discardableResult func write(
			_ string: String,
			to file: String,
			encoding: String.Encoding = .utf8
		) throws -> URL {
			let tempURL = self.folder.appendingPathComponent(file)
			try string.write(to: tempURL, atomically: true, encoding: encoding)
			return tempURL
		}
	}
}

class ImageOutput {

	let _imagesFolder: TestFilesContainer.Subfolder

	init(_ folder: TestFilesContainer.Subfolder) {
		_imagesFolder = folder
	}

	func store(_ data: Data, filename: String) throws -> String {
		try _imagesFolder.write(data, to: filename)
		return "./images/\(filename)"
	}

	func store(_ string: String, filename: String) throws -> String {
		try _imagesFolder.write(string, to: filename)
		return "./images/\(filename)"
	}
}
