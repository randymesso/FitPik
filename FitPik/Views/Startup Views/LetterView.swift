//
//  LetterView.swift
//  FitPik
//
//  Created by Randy Messo on 10/7/25.
//


struct LetterView: View {
  let letter: String
  let index: Int
  let animate: Bool
  
  @State private var offset: CGSize = .zero
  @State private var rotation: Angle = .zero
  @State private var opacity: Double = 0.0
  
  var body: some View {
    Text(letter)
      .font(.system(size: 36, weight: .bold, design: .rounded))
      .opacity(opacity)
      .rotationEffect(rotation)
      .offset(offset)
      .onAppear {
        // start off-screen in a random direction
        let directions: [CGSize] = [
          CGSize(width: -200, height: -100),
          CGSize(width: 200, height: -120),
          CGSize(width: -160, height: 140),
          CGSize(width: 180, height: 160),
          CGSize(width: 0, height: -220),
          CGSize(width: 0, height: 220),
          CGSize(width: -240, height: 0),
          CGSize(width: 240, height: 0)
        ]
        // choose a direction based on index but bounded by available directions
        let start = directions[index % directions.count]
        offset = start
        rotation = Angle(degrees: Double((index % 4) * 45))
        opacity = 0.0
      }
      .onChange(of: animate) { newValue in
        if newValue {
          // stagger animation by index
          let delay = Double(index) * 0.03
          withAnimation(.interpolatingSpring(stiffness: 120, damping: 12).delay(delay)) {
            offset = .zero
            rotation = .degrees(0)
            opacity = 1.0
          }
        }
      }
  }
}