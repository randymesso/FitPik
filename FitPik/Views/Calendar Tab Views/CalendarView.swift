import SwiftUI


struct CalendarView: View {
  var body: some View {
    VStack {
      Text("Calendar")
        .font(.title2).bold()
        .padding(.top)
      Text("View your worn history and events.")
        .foregroundColor(.secondary)
        .padding()
      Spacer()
    }
    .navigationTitle("Calendar")
  }
}
