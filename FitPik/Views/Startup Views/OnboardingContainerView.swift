//
//  OnboardingContainerView.swift
//  FitPik
//
//  Created by Randy Messo on 10/7/25.
//


struct OnboardingContainerView: View {
  @EnvironmentObject var appState: AppState
  @State private var currentPage = 0
  
  var body: some View {
    VStack {
      TabView(selection: $currentPage) {
        OnboardingPageView(
          title: "Upload your wardrobe",
          description: "Upload tops, bottoms, dresses, or shoes and get personalized wardrobe recommendations.",
          imageName: "wardrobe"
        )
        .tag(0)
        
        OnboardingPageView(
          title: "Save custom preferences",
          description: "Use custom preferences to save the scenarios you want to wear them.",
          imageName: "preferences"
        )
        .tag(1)
        
        OnboardingNameEntryView { name in
          appState.completeOnboarding(withName: name)
        }
        .tag(2)
      }
      .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
      .indexViewStyle(.page(backgroundDisplayMode: .interactive))
      .animation(.easeInOut, value: currentPage)
      .padding(.top, 30)
      
      HStack {
        if currentPage < 2 {
          Button("Skip") {
            // If user skips, still mark onboarding complete but leave name blank
            appState.completeOnboarding(withName: appState.userName ?? "")
          }
          .padding(.horizontal)
        }
        
        Spacer()
        
        Button(action: {
          if currentPage < 2 {
            currentPage += 1
          } else {
            // handled by the final page's completion callback
          }
        }) {
          Text(currentPage < 2 ? "Next" : "Done")
            .bold()
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding(.horizontal)
      }
      .padding(.bottom, 28)
      .padding(.horizontal)
    }
  }
}