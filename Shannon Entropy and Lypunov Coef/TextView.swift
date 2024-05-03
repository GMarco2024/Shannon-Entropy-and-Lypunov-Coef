import SwiftUI
import UniformTypeIdentifiers

// SwiftUI view that displays text data from plot calculations
struct TextView: View {
    
// Environment object to access shared data throughout the app
    @EnvironmentObject var plotData: PlotClass
// State variable to track which text data to display
    @State private var textSelector = 0

    var body: some View {
        VStack {
            TextEditor(text: .constant(formatText(text: plotData.plotArray[textSelector].calculatedText)))
                .padding()
 
        }
        .padding()
    }

    // Function to format the text data for better readability
    func formatText(text: String) -> String {
    // Split the input text into lines
        let lines = text.split(separator: "\n")
        guard !lines.isEmpty else { return "" }

        var formattedLines = [String]()
        let headers = lines.first?.split(separator: ",").map { $0.split(separator: ":")[0] }.joined(separator: ", ")
        formattedLines.append(headers ?? "")

        for line in lines {
            let values = line.split(separator: ",").map { $0.split(separator: ":")[1].trimmingCharacters(in: .whitespaces) }
            // Join the values with commas and add to the formatted lines
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


