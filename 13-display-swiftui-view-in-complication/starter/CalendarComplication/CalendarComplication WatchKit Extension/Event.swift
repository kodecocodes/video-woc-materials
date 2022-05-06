import EventKit
import SwiftUI

struct Event {
  let color: Color
  let startDate: Date
  let endDate: Date
  let title: String
  let location: String?
}

extension Event {
  init(ekEvent: EKEvent) {
    color = Color(ekEvent.calendar.cgColor)
    startDate = ekEvent.startDate
    endDate = ekEvent.endDate
    title = ekEvent.title
    location = ekEvent.location
  }
}


