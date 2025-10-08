import SwiftUI


struct MainContentView: View {
  @EnvironmentObject var appState: AppState
  @State private var selectedTab: Tab = .home
  
  enum Tab {
    case home, closet, outfits, calendar, more
  }
  
  var body: some View {
    TabView(selection: $selectedTab) {
      NavigationView {
        HomeView()
          .environmentObject(appState)
      }
      .tabItem {
        Label("Home", systemImage: "house.fill")
      }
      .tag(Tab.home)
      
      NavigationView {
        ClosetView()
          .environmentObject(appState)
      }
      .tabItem {
        Label("Closet", systemImage: "tshirt.fill")
      }
      .tag(Tab.closet)
      
      NavigationView {
        OutfitsView()
          .environmentObject(appState)
      }
      .tabItem {
        Label("Outfits", systemImage: "square.grid.2x2.fill")
      }
      .tag(Tab.outfits)
      
      NavigationView {
        CalendarView()
          .environmentObject(appState)
      }
      .tabItem {
        Label("Calendar", systemImage: "calendar")
      }
      .tag(Tab.calendar)
      
      NavigationView {
        MoreView()
          .environmentObject(appState)
      }
      .tabItem {
        Label("More", systemImage: "ellipsis.circle")
      }
      .tag(Tab.more)
    }
    .accentColor(.accentColor)
    .onAppear {
      // Any startup logic for the main dashboard can go here
    }
  }
}
