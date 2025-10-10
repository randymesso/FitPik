import SwiftUI


struct ClosetView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var vm = ClosetViewModel()
    @State private var showingCamera = false
    @State private var capturedImage: UIImage? = nil
    @State private var showingEditForCapture = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 12) {
                    greetingHeader
                    RecentUploadsView(vm: vm)
                        .padding(.horizontal)
                    Spacer()
                }
                .navigationTitle("Closet")
               
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        FloatingCameraButton {
                            // open camera
                            showingCamera = true
                        }
                        Spacer()
                    }
                    .padding(.bottom, 12)
                }
            }
        }
        .sheet(isPresented: $showingCamera) {
            CameraPicker(sourceType: .camera) { image in
                showingCamera = false
                guard let img = image else { return }
                capturedImage = img
                showingEditForCapture = true
            }
        }
        .sheet(isPresented: $showingEditForCapture) {
            if let toEditImage = capturedImage {
                EditUploadView(image: toEditImage) { category, tags in
                    vm.addItem(image: toEditImage, category: category, tags: tags)
                    showingEditForCapture = false
                    capturedImage = nil
                } onCancel: {
                    showingEditForCapture = false
                    capturedImage = nil
                }
            } else {
                Text("No image")
            }
        }
    }
    
    private var greetingHeader: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Welcome to \(appState.userName?.isEmpty == false ? appState.userName! : "Guest")'s Closet")
                    .font(.title2)
                    .bold()
                Text("Recent uploads & your wardrobe")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}
