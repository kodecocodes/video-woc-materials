import WatchKit
import ClockKit

final class ExtensionDelegate: NSObject, WKExtensionDelegate {
  private let backgroundWorker = BackgroundWorker()

  public static func updateActiveComplications() {
    let server = CLKComplicationServer.sharedInstance()
    server.activeComplications?.forEach {
      server.reloadTimeline(for: $0)
    }
  }

  func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
    backgroundTasks.forEach { task in
      switch task {
      case let task as WKApplicationRefreshBackgroundTask:
        // Perform work
        backgroundWorker.perform { updateComplications in
          // Update complication, if needed
          if updateComplications {
            Self.updateActiveComplications()
          }
          // Schedule next task
          backgroundWorker.schedule()
          // Mark task completed
          task.setTaskCompletedWithSnapshot(false)
        }
        
      default: task.setTaskCompletedWithSnapshot(false)
      }
    }
  }
}
