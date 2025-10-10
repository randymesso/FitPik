import SwiftUI


struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @State private var isMorningReminderOn: Bool = true
    @State private var refreshing = false
    @State private var suggestionConfidence: Double = 0.78
    @State private var suggestionReason: String = "Rainy + Casual + Brunch"
    @State private var suggestedOutfitTitle: String = "Cozy Rainy Brunch"
    
    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                greetingHeader
                
                TodayOutfitCard(title: suggestedOutfitTitle,
                                reason: suggestionReason,
                                confidence: suggestionConfidence,
                                refreshing: $refreshing)
                .padding(.horizontal)
                
                WeatherWidgetView()
                    .padding(.horizontal)
                
                QuickAccessGrid {
                    // Actions for quick access buttons
                }
                .padding(.horizontal)
                
                Toggle(isOn: $isMorningReminderOn) {
                    Text("Morning Reminder")
                        .font(.headline)
                }
                .padding(.horizontal)
                .padding(.top, 6)
                
                Spacer(minLength: 40)
            }
            .padding(.top)
        }
        .navigationTitle("FitPik")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    refreshSuggestion()
                }) {
                    if refreshing {
                        ProgressView()
                    } else {
                        Image(systemName: "arrow.clockwise")
                    }
                }
                .accessibilityLabel("Refresh suggestion")
            }
        }
    }
    
    private var greetingHeader: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Hi, \(appState.userName?.isEmpty == false ? appState.userName! : "There")!")
                    .font(.title2)
                    .bold()
                Text("Here's today's suggestion for you")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
    
    // Simulate recompute (replace with real algorithm)
    private func refreshSuggestion() {
        refreshing = true
        // simulate network / compute delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            // update with new dummy values (in real app, compute using actual data)
            suggestionConfidence = Double.random(in: 0.4...0.95)
            suggestionReason = ["Sunny + Casual", "Rainy + Cozy", "Cold + Formal", "Warm + Sporty"].randomElement()!
            suggestedOutfitTitle = ["Sunny Stroll", "Cozy Brunch", "Office Ready", "Gym Cute"].randomElement()!
            refreshing = false
        }
    }
}
