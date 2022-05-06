import SwiftUI
import EventKit

struct EventView: View {
  @ObservedObject private var eventStore = EventStore.shared
  private let formatter: DateIntervalFormatter = {
    let formatter = DateIntervalFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    return formatter
  }()

  var body: some View {
    VStack {
      if eventStore.calendarAccessGranted == false {
        Text("This app requires calendar permission.")
      } else if let event = eventStore.nextEvent {
        HStack {
          RoundedRectangle(cornerRadius: 3)
            .frame(width: 5)
            .foregroundColor(Color(event.calendar.cgColor))

          VStack(alignment: .leading) {
            Text(formatter.string(from: event.startDate, to: event.endDate))
              .font(.subheadline)
            Text(event.title)
              .font(.headline)
            if let location = event.location {
              Text(location)
                .font(.subheadline)
            }
          }
        }
      } else {
        Text("No more events today.")
      }
    }
    .task {
      eventStore.requestAccess()
    }
  }
}

struct EventView_Previews: PreviewProvider {
  static var previews: some View {
    EventView()
  }
}
