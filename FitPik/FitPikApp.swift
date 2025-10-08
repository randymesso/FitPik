import SwiftUI
import CloudKit

// MARK: - App entry

@main
struct FitPikApp: App {
  @StateObject private var appState = AppState()
  
  var body: some Scene {
    WindowGroup {
      Group {
        if appState.showSplash {
          SplashView()
            .environmentObject(appState)
        } else if appState.needsOnboarding {
          OnboardingContainerView()
            .environmentObject(appState)
        } else {
          MainContentView()
            .environmentObject(appState)
        }
      }
      .onAppear {
        appState.checkLaunchState()
      }
    }
  }
}
