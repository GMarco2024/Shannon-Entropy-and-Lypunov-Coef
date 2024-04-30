import SwiftUI
import UniformTypeIdentifiers

struct TextView: View {
    @EnvironmentObject var plotData: PlotClass
    @State private var textSelector = 0

    var body: some View {
        VStack {
            TextEditor(text: $plotData.plotArray[textSelector].calculatedText)
                .padding()
              
        }
        .padding()
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView().environmentObject(PlotClass())
    }
}
