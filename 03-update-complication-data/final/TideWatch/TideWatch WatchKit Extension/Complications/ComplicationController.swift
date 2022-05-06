import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {
  func currentTimelineEntry(for complication: CLKComplication) async -> CLKComplicationTimelineEntry? {
    guard
      complication.family == .graphicCircular,
      let tide = Tide.getCurrent()
    else {
      return nil
    }

    let template = CLKComplicationTemplateGraphicCircularStackImage(
      line1ImageProvider: .init(fullColorImage: tide.image()),
      line2TextProvider: .init(format: tide.heightString()))

    return .init(date: tide.date, complicationTemplate: template)
  }

  func complicationDescriptors() async -> [CLKComplicationDescriptor] {
    [
      .init(
        identifier: "com.yourcompany.TideWatch",
        displayName: "Tide Conditions",
        supportedFamilies: [.graphicCircular])
    ]
  }

  func localizableSampleTemplate(
    for complication: CLKComplication
  ) async -> CLKComplicationTemplate? {
    guard complication.family == .graphicCircular,
          let image = UIImage(named: "tide_rising")
    else {
      return nil
    }

    let tide = Tide(entity: Tide.entity(), insertInto: nil)
    tide.date = Date()
    tide.height = 24
    tide.type = .high

    return CLKComplicationTemplateGraphicCircularStackImage(
      line1ImageProvider: .init(fullColorImage: image),
      line2TextProvider: .init(format: tide.heightString()))
  }
}
