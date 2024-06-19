import SwiftUI
import CoreNFC

struct NFCSharingView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var showingShareOptions = false
    @State private var showingCustomShareSheet = false
    @State private var nfcMessage: NFCNDEFMessage?
    @State private var selectedItems = Set<String>()

    var body: some View {
        VStack {
            Button(action: {
                NFCService().startSession { result in
                    switch result {
                    case .success(let message):
                        nfcMessage = message
                        showingShareOptions = true
                    case .failure(let error):
                        print("NFC reading failed: \(error)")
                    }
                }
            }) {
                Text("Tap to Share Contact")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            if let nfcMessage = nfcMessage {
                Text("Detected NFC message")
                    .padding()
                Button("Do you want to share contact with user XYZ?") {
                    showingShareOptions = true
                }
                .actionSheet(isPresented: $showingShareOptions) {
                    ActionSheet(title: Text("Share Contact"), message: Text("Choose an option"), buttons: [
                        .default(Text("Yes"), action: {
                            shareDefaultContact()
                        }),
                        .cancel(Text("No")),
                        .default(Text("Custom"), action: {
                            showingCustomShareSheet = true
                        })
                    ])
                }
                .sheet(isPresented: $showingCustomShareSheet) {
                    CustomShareOptionsView(selectedItems: $selectedItems, onShare: shareCustomContact)
                }
            }
        }
    }

    func shareDefaultContact() {
        guard let user = userViewModel.user else {
            return
        }

        let defaultProfile = user.defaultProfile

        var contactInfo = ""
        if defaultProfile.name { contactInfo += "Name: \(user.name)\n" }
        if defaultProfile.linkedin == true { contactInfo += "LinkedIn: \(user.linkedin)\n" }
        if defaultProfile.email == true { contactInfo += "Email: \(user.email)\n" }
        if defaultProfile.secondaryEmail == true { contactInfo += "Secondary Email: \(user.secondaryEmail)\n" }
        if defaultProfile.github == true { contactInfo += "GitHub: \(user.github)\n" }
        if defaultProfile.business == true { contactInfo += "Business: \(user.business)\n" }

        guard let contactPayload = NFCNDEFPayload.wellKnownTypeURIPayload(string: contactInfo) else {
            print("Failed to create NFC payload")
            return
        }

        let message = NFCNDEFMessage(records: [contactPayload])
        NFCService().sendNFCMessage(message)
    }

    func shareCustomContact() {
        guard let user = userViewModel.user else {
            return
        }

        var contactInfo = ""
        if selectedItems.contains("name") { contactInfo += "Name: \(user.name)\n" }
        if selectedItems.contains("linkedin") { contactInfo += "LinkedIn: \(user.linkedin)\n" }
        if selectedItems.contains("email") { contactInfo += "Email: \(user.email)\n" }
        if selectedItems.contains("secondaryEmail") { contactInfo += "Secondary Email: \(user.secondaryEmail)\n" }
        if selectedItems.contains("github") { contactInfo += "GitHub: \(user.github)\n" }
        if selectedItems.contains("business") { contactInfo += "Business: \(user.business)\n" }

        guard let contactPayload = NFCNDEFPayload.wellKnownTypeURIPayload(string: contactInfo) else {
            print("Failed to create NFC payload")
            return
        }

        let message = NFCNDEFMessage(records: [contactPayload])
        NFCService().sendNFCMessage(message)
    }
}

struct CustomShareOptionsView: View {
    @Binding var selectedItems: Set<String>
    var onShare: () -> Void

    var body: some View {
        VStack {
            Text("Select items to share:")
            Toggle("Name", isOn: Binding(
                get: { selectedItems.contains("name") },
                set: { if $0 { selectedItems.insert("name") } else { selectedItems.remove("name") } }
            ))
            Toggle("LinkedIn", isOn: Binding(
                get: { selectedItems.contains("linkedin") },
                set: { if $0 { selectedItems.insert("linkedin") } else { selectedItems.remove("linkedin") } }
            ))
            Toggle("Email", isOn: Binding(
                get: { selectedItems.contains("email") },
                set: { if $0 { selectedItems.insert("email") } else { selectedItems.remove("email") } }
            ))
            Toggle("Secondary Email", isOn: Binding(
                get: { selectedItems.contains("secondaryEmail") },
                set: { if $0 { selectedItems.insert("secondaryEmail") } else { selectedItems.remove("secondaryEmail") } }
            ))
            Toggle("GitHub", isOn: Binding(
                get: { selectedItems.contains("github") },
                set: { if $0 { selectedItems.insert("github") } else { selectedItems.remove("github") } }
            ))
            Toggle("Business", isOn: Binding(
                get: { selectedItems.contains("business") },
                set: { if $0 { selectedItems.insert("business") } else { selectedItems.remove("business") } }
            ))
            Button("Share Selected") {
                onShare()
            }
            .padding()
        }
        .padding()
    }
}
