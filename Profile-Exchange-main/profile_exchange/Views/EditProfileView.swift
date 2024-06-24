import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var secondaryEmail: String = ""
    @State private var linkedIn: String = ""
    @State private var githubURL: String = ""
    @State private var businessInfo: String = ""
    @State private var defaultShare: [ContactInfo] = []

    var body: some View {
        Form {
            Section(header: Text("Basic Information")) {
                TextField("Name", text: $name)
                TextField("Email", text: $email)
                TextField("Secondary Email", text: $secondaryEmail)
                TextField("LinkedIn", text: $linkedIn)
                TextField("GitHub URL", text: $githubURL)
                TextField("Business Info", text: $businessInfo)
            }
            Section(header: Text("Default Share Settings")) {
                Toggle(isOn: Binding(
                    get: { defaultShare.contains(.email) },
                    set: { if $0 { defaultShare.append(.email) } else { defaultShare.removeAll { $0 == .email } } }
                )) {
                    Text("Share Email")
                }
                Toggle(isOn: Binding(
                    get: { defaultShare.contains(.secondaryEmail) },
                    set: { if $0 { defaultShare.append(.secondaryEmail) } else { defaultShare.removeAll { $0 == .secondaryEmail } } }
                )) {
                    Text("Share Secondary Email")
                }
                Toggle(isOn: Binding(
                    get: { defaultShare.contains(.linkedIn) },
                    set: { if $0 { defaultShare.append(.linkedIn) } else { defaultShare.removeAll { $0 == .linkedIn } } }
                )) {
                    Text("Share LinkedIn")
                }
                Toggle(isOn: Binding(
                    get: { defaultShare.contains(.githubURL) },
                    set: { if $0 { defaultShare.append(.githubURL) } else { defaultShare.removeAll { $0 == .githubURL } } }
                )) {
                    Text("Share GitHub URL")
                }
                Toggle(isOn: Binding(
                    get: { defaultShare.contains(.businessInfo) },
                    set: { if $0 { defaultShare.append(.businessInfo) } else { defaultShare.removeAll { $0 == .businessInfo } } }
                )) {
                    Text("Share Business Info")
                }
            }
        }
        .onAppear {
            let user = userViewModel.currentUser
            name = user?.name ?? ""
            email = user?.email ?? ""
            secondaryEmail = user?.secondaryEmail ?? ""
            linkedIn = user?.linkedIn ?? ""
            githubURL = user?.githubURL ?? ""
            businessInfo = user?.businessInfo ?? ""
            defaultShare = user?.defaultShare ?? []
        }
        .onDisappear {
            let updatedUser = User(
                id: userViewModel.currentUser?.id ?? UUID().uuidString,
                name: name,
                email: email,
                secondaryEmail: secondaryEmail,
                linkedIn: linkedIn,
                githubURL: githubURL,
                businessInfo: businessInfo,
                defaultShare: defaultShare
            )
            userViewModel.updateUser(updatedUser)
        }
    }
}
