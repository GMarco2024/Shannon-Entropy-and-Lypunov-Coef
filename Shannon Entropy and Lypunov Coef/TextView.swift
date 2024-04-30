import SwiftUI
import UniformTypeIdentifiers

struct TextView: View {
    @EnvironmentObject var plotData: PlotClass
    @State private var textSelector = 0

    var body: some View {
        VStack {
            TextEditor(text: .constant(formatText(text: plotData.plotArray[textSelector].calculatedText)))
                .padding()
 
        }
        .padding()
    }

    func formatText(text: String) -> String {
        let lines = text.split(separator: "\n")
        guard !lines.isEmpty else { return "" }

        var formattedLines = [String]()
        let headers = lines.first?.split(separator: ",").map { $0.split(separator: ":")[0] }.joined(separator: ", ")
        formattedLines.append(headers ?? "")

        for line in lines {
            let values = line.split(separator: ",").map { $0.split(separator: ":")[1].trimmingCharacters(in: .whitespaces) }
            formattedLines.append(values.joined(separator: ", "))
        }

        return formattedLines.joined(separator: "\n")
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView().environmentObject(PlotClass())
    }
}


