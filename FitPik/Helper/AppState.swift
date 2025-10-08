import SwiftUI
import CloudKit
import Security


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
    /*
     In order to use CloudKit, your process must have a com.apple.developer.icloud-services entitlement. The value of this entitlement must be an array that includes the string "CloudKit" or "CloudKit-Anonymous".
     */
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
    
//    /// Returns true if the app binary has the iCloud "CloudKit" entitlement present
//    func hasCloudKitEntitlement() -> Bool {
//      guard let task = SecTaskCreateFromSelf(nil) else { return false }
//      // This returns CFTypeRef? — entitlement may be an array or value if present.
//      if let cfValue = SecTaskCopyValueForEntitlement(task, "com.apple.developer.icloud-services" as CFString, nil) {
//        // If not nil, entitlement exists. Could inspect contents if desired.
//        // Example: it might be an array that contains "CloudKit" as a CFString.
//        if let arr = cfValue as? [Any] {
//          return arr.contains { ($0 as? String) == "CloudKit" || ($0 as? String) == "CloudKit-Anonymous" }
//        } else if let s = cfValue as? String {
//          // single string (rare) — check it
//          return s == "CloudKit" || s == "CloudKit-Anonymous"
//        } else if let num = cfValue as? NSNumber {
//          // just in case — treat as present
//          return num.boolValue
//        }
//        // fallback: non-nil means some entitlement is present
//        return true
//      }
//      return false
//    }
    
}
