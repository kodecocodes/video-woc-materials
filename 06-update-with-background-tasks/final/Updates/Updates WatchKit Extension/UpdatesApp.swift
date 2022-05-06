import SwiftUI

@main
struct UpdatesApp: App {
  @WKExtensionDelegateAdaptor(ExtensionDelegate.self)
  private var extensionDelegate

  var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
      }
    }
  }
}
