import ClockKit

struct GraphicCircular: ComplicationTemplateFactory {
  func template(for waterLevel: Tide) -> CLKComplicationTemplate {
    CLKComplicationTemplateGraphicCircularStackImage(
      line1ImageProvider: fullColorImageProvider(for: waterLevel),
      line2TextProvider: textProvider(for: waterLevel))
  }
}
