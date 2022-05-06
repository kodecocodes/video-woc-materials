import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {
  func currentTimelineEntry(for complication: CLKComplication) async -> CLKComplicationTimelineEntry? {
    guard complication.family == .graphicCircular else {
      return nil
    }

    let template = CLKComplicationTemplateGraphicCircularStackText(
      line1TextProvider: .init(format: "Surf's"),
      line2TextProvider: .init(format: "Up!"))

    return .init(date: Date(), complicationTemplate: template)
  }

  func complicationDescriptors() async -> [CLKComplicationDescriptor] {
    [
      .init(
        identifier: "com.yourcompany.TideWatch",
        displayName: "Tide Conditions",
        supportedFamilies: [.graphicCircular])
    ]
  }
}
