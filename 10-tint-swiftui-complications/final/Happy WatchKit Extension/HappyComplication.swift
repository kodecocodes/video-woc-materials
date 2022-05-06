import ClockKit
import SwiftUI

struct HappyComplication: View {
  @Environment(\.complicationRenderingMode) var renderingMode

  var body: some View {
    if renderingMode == .fullColor {
      Image("full")
        .complicationForeground()
    } else {
      ZStack {
        Circle()
          .fill(
            LinearGradient(
              colors: [.pink.opacity(1), .teal.opacity(0.1)],
              startPoint: .top, endPoint: .bottom))
        Image("background")

        Image("outlines")
          .complicationForeground()
      }
    }
  }
}

struct HappyComplication_Previews: PreviewProvider {
  static var previews: some View {
    ForEach(CLKComplicationTemplate.PreviewFaceColor.allColors) {
      CLKComplicationTemplateGraphicExtraLargeCircularView(
        HappyComplication()
      )
      .previewContext(faceColor: $0)
    }
  }
}
