import WatchKit
import ClockKit

final class ExtensionDelegate: NSObject, WKExtensionDelegate {
  private let backgroundWorker = BackgroundWorker()
  private var downloads: [String: URLDownloader] = [:]

  private func downloader(for identifier: String) -> URLDownloader {
    guard let download = downloads[identifier] else {
      let downloader = URLDownloader(identifier: identifier)
      downloads[identifier] = downloader
      return downloader
    }

    return download
  }

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
        backgroundWorker.perform { updateComplications in
          if updateComplications { Self.updateActiveComplications()}

          backgroundWorker.schedule()
          task.setTaskCompletedWithSnapshot(false)
        }
      case let task as WKURLSessionRefreshBackgroundTask:
        let downloader = downloader(for: task.sessionIdentifier)
        downloader.perform { updateComplications in
          if updateComplications {
            Self.updateActiveComplications()
          }

          downloader.schedule()
          self.downloads[task.sessionIdentifier] = nil
          task.setTaskCompletedWithSnapshot(false)
        }

      default: task.setTaskCompletedWithSnapshot(false)
      }
    }
  }
}
