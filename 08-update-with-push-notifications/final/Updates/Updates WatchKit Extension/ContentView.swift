import SwiftUI

struct ContentView: View {
  @State private var downloader = URLDownloader(identifier: "ContentView")
  var body: some View {
    Button("Download") {
      downloader.schedule(firstTime: true)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
