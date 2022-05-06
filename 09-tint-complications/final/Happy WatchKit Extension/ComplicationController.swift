import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {
  func complicationDescriptors() async -> [CLKComplicationDescriptor] {
    return [
      .init(
        identifier: "com.yourcompany.Happy",
        displayName: "Happy",
        supportedFamilies: [
          .graphicExtraLarge
        ]
      )
    ]
  }

  func currentTimelineEntry(for complication: CLKComplication) async -> CLKComplicationTimelineEntry? {
    let template = await localizableSampleTemplate(for: complication)!
    return .init(date: Date.now, complicationTemplate: template)
  }

  func localizableSampleTemplate(for complication: CLKComplication) async -> CLKComplicationTemplate? {
    guard
      let full = UIImage(named: "full"),
      let background = UIImage(named: "background"),
      let outlines = UIImage(named: "outlines")
    else {
      fatalError("Images are missing from asset catalog.")
    }

    return CLKComplicationTemplateGraphicExtraLargeCircularImage(
      imageProvider: CLKFullColorImageProvider(
        fullColorImage: full,
        tintedImageProvider: CLKImageProvider(
          onePieceImage: full,
          twoPieceImageBackground: background,
          twoPieceImageForeground: outlines)
      )
    )
  }
}
