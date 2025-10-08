//
//  AppState.swift
//  FitPik
//
//  Created by Randy Messo on 10/7/25.
//


final class AppState: ObservableObject {
  @Published var showSplash: Bool = true
  @Published var needsOnboarding: Bool = true
  @Published var iCloudAvailable: Bool = false
  @Published var userName: String? = nil
  
  private let onboardKey = "FitPikHasCompletedOnboarding"
  private let nameKey = "FitPikUserName"
  
  func checkLaunchState() {
    // Show splash for a short time, then decide
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
      guard let self = self else { return }
      self.showSplash = false
      self.loadName()
      self.checkiCloudAccount()
      
      let hasCompleted = UserDefaults.standard.bool(forKey: self.onboardKey)
      // if not completed onboarding or not signed into iCloud -> show onboarding
      self.needsOnboarding = !hasCompleted || !self.iCloudAvailable
      // Note: Since checkiCloudAccount is async, update of needsOnboarding will occur when account check completes
    }
  }
  
  private func loadName() {
    if let name = UserDefaults.standard.string(forKey: nameKey) {
      userName = name
    } else if let name = NSUbiquitousKeyValueStore.default.string(forKey: nameKey) {
      userName = name
    }
  }
  
  func completeOnboarding(withName name: String) {
    UserDefaults.standard.set(true, forKey: onboardKey)
    UserDefaults.standard.set(name, forKey: nameKey)
    userName = name
    
    // attempt to save to iCloud KVS if available
    if iCloudAvailable {
      NSUbiquitousKeyValueStore.default.set(name, forKey: nameKey)
      NSUbiquitousKeyValueStore.default.synchronize()
    }
    needsOnboarding = false
  }
  
  func checkiCloudAccount() {
    // CloudKit account status check
    CKContainer.default().accountStatus { [weak self] status, error in
      DispatchQueue.main.async {
        guard let self = self else { return }
        if let e = error {
          print("CloudKit accountStatus error: \(e)")
          self.iCloudAvailable = false
        } else {
          self.iCloudAvailable = (status == .available)
        }
        // If onboarding hasn't been completed, reflect latest iCloud status
        let hasCompleted = UserDefaults.standard.bool(forKey: self.onboardKey)
        self.needsOnboarding = !hasCompleted || !self.iCloudAvailable
      }
    }
  }
}