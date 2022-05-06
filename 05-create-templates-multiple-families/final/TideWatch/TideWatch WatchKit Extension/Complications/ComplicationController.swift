import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {
  func currentTimelineEntry(for complication: CLKComplication) async -> CLKComplicationTimelineEntry? {
    guard
      let factory = ComplicationTemplates.generate(for: complication),
      let tide = Tide.getCurrent()
    else { return nil }

    let template = factory.template(for: tide)
    return .init(date: tide.date, complicationTemplate: template)
  }

  func complicationDescriptors() async -> [CLKComplicationDescriptor] {
    [
      .init(
        identifier: "com.yourcompany.TideWatch",
        displayName: "Tide Conditions",
        supportedFamilies: [
          .circularSmall, .extraLarge, .graphicBezel, .graphicCircular, .graphicCorner,
          .modularSmall, .utilitarianLarge, .utilitarianSmall, .utilitarianSmallFlat
        ])
    ]
  }

  func localizableSampleTemplate(
    for complication: CLKComplication
  ) async -> CLKComplicationTemplate? {
    ComplicationTemplates.generate(for: complication)?.templateForSample()
  }
}
