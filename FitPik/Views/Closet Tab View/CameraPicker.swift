import SwiftUI


struct CameraPicker: UIViewControllerRepresentable {
    enum SourceType {
        case camera, photoLibrary
    }
    var sourceType: SourceType = .camera
    var onComplete: (UIImage?) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        picker.sourceType = (sourceType == .camera && UIImagePickerController.isSourceTypeAvailable(.camera)) ? .camera : .photoLibrary
        return picker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraPicker
        init(parent: CameraPicker) { self.parent = parent }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.onComplete(nil)
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            var image: UIImage?
            if let edited = info[.editedImage] as? UIImage {
                image = edited
            } else if let original = info[.originalImage] as? UIImage {
                image = original
            }
            parent.onComplete(image)
        }
    }
}
