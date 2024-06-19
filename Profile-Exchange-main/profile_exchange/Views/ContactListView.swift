import SwiftUI

struct ContactListView: View {
    @EnvironmentObject var contactViewModel: ContactViewModel

    var body: some View {
        List {
            ForEach(contactViewModel.sharedContacts) { contact in
                VStack(alignment: .leading) {
                    Text("Contact ID: \(contact.id)")
                    ForEach(contact.sharedContactInfo.sorted(by: { $0.key.rawValue < $1.key.rawValue }), id: \.key) { key, value in
                        Text("\(key.rawValue.capitalized): \(value)")
                    }
                }
                .id(contact.id) // Ensure each VStack has a unique identifier
            }
            .onDelete { indices in
                contactViewModel.removeContacts(at: indices)
            }
        }
        .navigationTitle("Shared Contacts")
    }
}
