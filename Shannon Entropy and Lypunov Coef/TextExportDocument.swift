//
//  TextExportDocument.swift
//  Filewrapper for text
//
//  Created by Jeff Terry on 8/25/22.
//  Modified by Marco Gonzalez 04/29/2024
//
//  Based upon code from https://github.com/acwright/ImportExport
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct TextExportDocument: FileDocument {
    
    static var readableContentTypes: [UTType] { [.plainText] }

    var message: String

    init(message: String) {
        self.message = message
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        message = string
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: message.data(using: .utf8)!)
    }
    
}
