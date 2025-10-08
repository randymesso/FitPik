struct SplashView: View {
  @EnvironmentObject var appState: AppState
  @State private var animateLetters = false
  
  private let title = "Welcome to FitPik!"
  
  var body: some View {
    ZStack {
      Color(.systemBackground).ignoresSafeArea()
      HStack(spacing: 0) {
        ForEach(Array(title.enumerated()), id: \.offset) { index, ch in
          LetterView(letter: String(ch), index: index, animate: animateLetters)
        }
      }
    }
    .onAppear {
      // trigger letter animations slightly staggered
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
        withAnimation(.easeOut(duration: 0.9)) {
          animateLetters = true
        }
      }
      
      // keep splash on screen a little longer (optional)
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
        // leave to AppState.checkLaunchState to hide splash
      }
    }
  }
}
