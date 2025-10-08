
// MARK: - MainContentView (placeholder for post-onboarding)

struct MainContentView: View {
  @EnvironmentObject var appState: AppState
  
  var body: some View {
    NavigationView {
      VStack(spacing: 16) {
        Text("Hi, \(appState.userName?.isEmpty == false ? appState.userName! : "There")!")
          .font(.title2)
          .bold()
          .padding(.top, 20)
        
        Text("This is the main app content. Home Dashboard will go here.")
          .foregroundColor(.secondary)
          .multilineTextAlignment(.center)
          .padding()
        
        Spacer()
      }
      .navigationTitle("FitPik")
    }
  }
}