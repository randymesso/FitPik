import SwiftUI


struct OnboardingPageView: View {
  let title: String
  let description: String
  let imageName: String // placeholder for your asset name
  
  var body: some View {
    VStack(spacing: 28) {
      Spacer()
      // Replace with your real asset images
      Image(systemName: "photo")
        .resizable()
        .scaledToFit()
        .frame(height: 220)
        .padding()
        .foregroundColor(.secondary)
      
      Text(title)
        .font(.title)
        .bold()
        .multilineTextAlignment(.center)
        .padding(.horizontal)
      
      Text(description)
        .font(.body)
        .multilineTextAlignment(.center)
        .foregroundColor(.secondary)
        .padding(.horizontal, 30)
      Spacer()
    }
  }
}
