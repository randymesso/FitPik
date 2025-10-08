import SwiftUI


struct WeatherWidgetView: View {
  // Placeholder values — replace with your WeatherService later
  @State private var temp: Int = 72
  @State private var condition: String = "Partly Cloudy"
  @State private var willRain: Bool = false
  @State private var dayPart: String = "Morning"
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 6) {
        Text("Weather")
          .font(.subheadline)
          .foregroundColor(.secondary)
        HStack(alignment: .firstTextBaseline, spacing: 8) {
          Text("\(temp)°")
            .font(.system(size: 44, weight: .bold))
          VStack(alignment: .leading) {
            Text(condition)
              .font(.headline)
            Text("\(dayPart) • \(willRain ? "Rain expected" : "No rain")")
              .font(.footnote)
              .foregroundColor(.secondary)
          }
        }
      }
      Spacer()
      Image(systemName: willRain ? "cloud.rain.fill" : "cloud.sun.fill")
        .font(.system(size: 36))
        .foregroundColor(.yellow)
    }
    .padding()
    .background(RoundedRectangle(cornerRadius: 14).fill(Color(UIColor.secondarySystemBackground)))
  }
}
