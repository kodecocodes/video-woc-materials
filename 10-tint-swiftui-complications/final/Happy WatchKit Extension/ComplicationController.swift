import ClockKit
import SwiftUI

class ComplicationController: NSObject, CLKComplicationDataSource {
  func complicationDescriptors() async -> [CLKComplicationDescriptor] {
    return [
      .init(
        identifier: "com.yourcompany.Happy",
        displayName: "Happy",
        supportedFamilies: [.graphicExtraLarge]
      )
    ]
  }

  func currentTimelineEntry(for complication: CLKComplication) async -> CLKComplicationTimelineEntry? {
    let template = await localizableSampleTemplate(for: complication)!
    return .init(date: Date.now, complicationTemplate: template)
  }

  func localizableSampleTemplate(for complication: CLKComplication) async -> CLKComplicationTemplate? {
    CLKComplicationTemplateGraphicExtraLargeCircularView(HappyComplication())
  }
}
