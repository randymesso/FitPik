//import CloudKit
//import SwiftUI
//
//class icloudstorage: ObservableObject {
//
//    private let database = CKContainer(identifier: "iCloud.iOSExample").privateCloudDatabase
//    
//    @Published var items: [CKRecord] = []
//    
//    init() {
//        fetchItems()
//    }
//    
//    func fetchItems() {
//        let query = CKQuery(recordType: "Item", predicate: NSPredicate(format: "TRUEPREDICATE"))
//        query.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
//    }
//}
