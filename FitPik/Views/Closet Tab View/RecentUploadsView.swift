import SwiftUI


struct RecentUploadsView: View {
    @ObservedObject var vm: ClosetViewModel
    @State private var expanded = false
    @State private var filter: ClosetCategory? = nil
    @State private var selectedItem: ClosetItem? = nil
    @State private var showingDetail = false
    var menuHeight = UIScreen.main.bounds.height * 0.3
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Recent uploads")
                    .font(.headline)
                Spacer()
                // Filter dropdown
                Menu {
                    Button("All", action: { filter = nil; vm.filterCategory = nil })
                    ForEach(ClosetCategory.allCases) { c in
                        Button(c.rawValue) {
                            filter = c
                            vm.filterCategory = c
                        }
                    }
                } label: {
                    HStack {
                        Text(filter?.rawValue ?? "Filter")
                        Image(systemName: "chevron.down")
                    }
                }
            }
            
            // collapsed view shows up to 3
            if !expanded {
                HStack(spacing: 8) {
                    ForEach(vm.recentThree.filter { filter == nil ? true : $0.category == filter }, id: \.id) { item in
                        RecentThumbnail(item: item)
                            .onTapGesture {
                                selectedItem = item
                                showingDetail = true
                            }
                    }
                    if vm.recentThree.count < 3 {
                        ForEach(0..<(3 - vm.recentThree.count), id: \.self) { _ in
                            Color.gray.opacity(0.15)
                                .frame(width: 100, height: 140)
                                .cornerRadius(8)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                // expanded grid (3 columns)
                ClosetGridView(items: vm.filteredItems, onTap: { item in
                    selectedItem = item
                    showingDetail = true
                })
                .frame(maxHeight: menuHeight)
            }
            
            Button(action: {
                withAnimation(.spring()) {
                    expanded.toggle()
                }
            }) {
                Text(expanded ? "Collapse" : "View All")
                    .font(.subheadline)
                    .bold()
            }
            .padding(.top, 6)
        }
        .sheet(isPresented: $showingDetail, onDismiss: { selectedItem = nil }) {
            if let item = selectedItem {
                ClosetItemDetailView(item: item) { updated in
                    vm.updateItem(updated)
                } onDelete: { toDelete in
                    vm.deleteItem(toDelete)
                    showingDetail = false
                }
            }
        }
    }
}
