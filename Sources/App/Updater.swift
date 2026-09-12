import Foundation
import Sparkle

/// Keeps Codenotch V.1 Pro ready for Adeleid-hosted updates.
///
/// Automatic checks are intentionally disabled in project.yml until Adeleid
/// publishes a signed appcast and release artifacts for this fork.
@MainActor
final class Updater: NSObject, ObservableObject, SPUUpdaterDelegate {
    enum Outcome: Equatable {
        case idle
        case checking
        case upToDate(Date)
        case found(String)
        case unreachable
        case failed(String)

        var message: String? {
            switch self {
            case .idle:          return nil
            case .checking:      return L10n.t("Checking…")
            case .upToDate:      return L10n.t("Codenotch V.1 Pro is up to date.")
            case .found(let v):  return L10n.t("Codenotch V.1 Pro version \(v) is available and will install shortly.")
            case .unreachable:
                return L10n.t("Couldn't reach the Adeleid update feed. This copy will keep working normally.")
            case .failed(let why): return why
            }
        }
    }

    @Published private(set) var outcome: Outcome = .idle

    private lazy var controller = SPUStandardUpdaterController(
        startingUpdater: true, updaterDelegate: self, userDriverDelegate: nil
    )

    var automatic: Bool {
        get { controller.updater.automaticallyChecksForUpdates }
        set {
            controller.updater.automaticallyChecksForUpdates = newValue
            controller.updater.automaticallyDownloadsUpdates = newValue
        }
    }

    var currentVersion: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "?"
    }

    var lastChecked: Date? { controller.updater.lastUpdateCheckDate }

    func start() { _ = controller }

    func checkNow() {
        outcome = .checking
        controller.updater.checkForUpdates()
    }

    // MARK: - SPUUpdaterDelegate

    nonisolated func updaterDidNotFindUpdate(_ updater: SPUUpdater) {
        Task { @MainActor in self.outcome = .upToDate(Date()) }
    }

    nonisolated func updater(_ updater: SPUUpdater, didFindValidUpdate item: SUAppcastItem) {
        let version = item.displayVersionString
        Task { @MainActor in self.outcome = .found(version) }
    }

    nonisolated func updater(_ updater: SPUUpdater, didAbortWithError error: Error) {
        let code = (error as NSError).code
        Task { @MainActor in
            self.outcome = Self.isUnreachable(code)
                ? .unreachable
                : .failed(error.localizedDescription)
        }
    }

    static func isUnreachable(_ code: Int) -> Bool {
        code == Int(SUError.appcastError.rawValue)
    }
}
