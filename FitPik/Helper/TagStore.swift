import SwiftUI

// MARK: - TagStore (persistent list of available tags)

final class TagStore: ObservableObject {
    @Published private(set) var allTags: [String] = []

    private let defaultsKey = "FitPik_Tags_v1"
    private let defaultTags: [String] = [
        "Casual","Brunch","Date Night","Party","Wedding","Formal","Cocktail",
        "Business Casual","Office","Interview","Conference","Presentation","Networking",
        "Church","Sunday Best","Travel","Beach","Pool","Vacation","Hiking","Workout",
        "Errands","Lounge","Sleepwear","Winter","Summer","Rainy Day","Festival","Concert",
        "Night Out","Fancy Dinner","Family Gathering","Holiday","Picnic","Movie Night",
        "School","Sports Game","Camping","Road Trip","Photoshoot","Maternity","Nursing Friendly",
        "Baby Shower","Graduation","Formal Work Event","Casual Work Event","First Date",
        "Anniversary","Gardening","DIY","Volunteering","Costume","Business Travel","Airport Comfort",
        "Recovery Day"
    ]

    static let shared = TagStore() // singleton convenience

    private init() {
        load()
    }

    private func load() {
        if let saved = UserDefaults.standard.array(forKey: defaultsKey) as? [String], !saved.isEmpty {
            allTags = saved
        } else {
            allTags = defaultTags
            save()
        }
    }

    private func save() {
        UserDefaults.standard.set(allTags, forKey: defaultsKey)
    }

    /// Add a custom tag (no duplicates, trims whitespace). Returns true if added.
    func addCustomTag(_ tag: String) -> Bool {
        let t = tag.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !t.isEmpty else { return false }
        if allTags.contains(where: { $0.caseInsensitiveCompare(t) == .orderedSame }) {
            return false
        }
        allTags.append(t)
        save()
        return true
    }

    /// Optionally: remove custom tag (if you want to support deletion)
    func removeTag(_ tag: String) {
        allTags.removeAll { $0.caseInsensitiveCompare(tag) == .orderedSame }
        save()
    }
}
