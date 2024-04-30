import SwiftUI
import UniformTypeIdentifiers

struct TextView: View {
    @EnvironmentObject var plotData: PlotClass  // Assumes plotData is injected from the parent view
    @State private var document: TextExportDocument = TextExportDocument(message: "")
    @State private var isImporting: Bool = false
    @State private var isExporting: Bool = false
    @State private var textSelector = 0  // Adjust this based on how you decide which data to show

    var body: some View {
        VStack {
            TextEditor(text: $plotData.plotArray[textSelector].calculatedText)
                .padding()
                .border(Color.gray, width: 1)  // Adding a border for clarity

            HStack {
                Button("Save", action: {
                    saveText()
                })
                .padding()

                Button("Load", action: {
                    loadText()
                })
                .padding()
            }
        }
        .fileImporter(
            isPresented: $isImporting,
            allowedContentTypes: [UTType.plainText],
            allowsMultipleSelection: false
        ) { result in
            handleImport(result: result)
        }
        .fileExporter(
            isPresented: $isExporting,
            document: document,
            contentType: UTType.plainText,
            defaultFilename: "ExportedData"
        ) { result in
            if case .success = result {
                print("File saved successfully.")
            } else {
                print("Failed to save file.")
            }
        }
        .padding()
    }

    private func saveText() {
        document.message = plotData.plotArray[textSelector].calculatedText
        isExporting = true
    }

    private func loadText() {
        isImporting = true
    }

    private func handleImport(result: Result<[URL], Error>) {
        do {
            guard let selectedFile = try result.get().first else { return }
            if CFURLStartAccessingSecurityScopedResource(selectedFile as CFURL) {
                let message = try String(contentsOf: selectedFile, encoding: .utf8)
                plotData.plotArray[textSelector].calculatedText = message
                CFURLStopAccessingSecurityScopedResource(selectedFile as CFURL)
            } else {
                print("Permission error!")
            }
        } catch {
            print("Failed to load the file: \(error.localizedDescription)")
        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView().environmentObject(PlotClass())
    }
}
