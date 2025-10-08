//
//  OnboardingNameEntryView.swift
//  FitPik
//
//  Created by Randy Messo on 10/7/25.
//


struct OnboardingNameEntryView: View {
  @EnvironmentObject var appState: AppState
  @State private var name: String = ""
  var onComplete: (String) -> Void
  
  var body: some View {
    VStack(spacing: 20) {
      Spacer()
      Image(systemName: "person.crop.circle.badge.plus")
        .resizable()
        .scaledToFit()
        .frame(height: 160)
        .foregroundColor(.secondary)
      
      Text("And what would you like me to call you?")
        .font(.title2)
        .bold()
        .multilineTextAlignment(.center)
        .padding(.horizontal)
      
      TextField("Your name", text: $name)
        .textFieldStyle(.roundedBorder)
        .padding(.horizontal, 40)
        .submitLabel(.done)
      
      Button(action: {
        // default to empty string if blank
        let finalName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        onComplete(finalName)
      }) {
        Text("Save & Continue")
          .bold()
          .frame(maxWidth: .infinity)
          .padding()
          .background(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.gray : Color.accentColor)
          .foregroundColor(.white)
          .cornerRadius(12)
          .padding(.horizontal, 40)
      }
      .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
      
      Spacer()
    }
    .onAppear {
      if let existing = appState.userName {
        name = existing
      }
    }
  }
}