import SwiftUI

class ContactViewModel: ObservableObject {
    @Published var sharedContacts: [Contact] = []

    init() {
        loadContacts()
    }

    func loadContacts() {
        sharedContacts = PersistenceService.loadContacts()
    }

    func removeContacts(at offsets: IndexSet) {
        sharedContacts.remove(atOffsets: offsets)
        PersistenceService.saveContacts(sharedContacts)
    }
}
