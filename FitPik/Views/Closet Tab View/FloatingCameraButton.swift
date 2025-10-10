import SwiftUI

struct FloatingCameraButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 64, height: 64)
                    .shadow(radius: 6)
                Image(systemName: "camera.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .bold))
            }
        }
        .padding(.bottom, 6)
        .accessibilityLabel("Add new item")
    }
}
