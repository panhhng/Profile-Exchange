import SwiftUI

struct CustomShareView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var selectedInfo: [ContactInfo] = []

    var body: some View {
        Form {
            Section(header: Text("Select Information to Share")) {
                Toggle(isOn: Binding(
                    get: { selectedInfo.contains(.email) },
                    set: { if $0 { selectedInfo.append(.email) } else { selectedInfo.removeAll { $0 == .email } } }
                )) {
                    Text("Share Email")
                }
                Toggle(isOn: Binding(
                    get: { selectedInfo.contains(.secondaryEmail) },
                    set: { if $0 { selectedInfo.append(.secondaryEmail) } else { selectedInfo.removeAll { $0 == .secondaryEmail } } }
                )) {
                    Text("Share Secondary Email")
                }
                Toggle(isOn: Binding(
                    get: { selectedInfo.contains(.linkedIn) },
                    set: { if $0 { selectedInfo.append(.linkedIn) } else { selectedInfo.removeAll { $0 == .linkedIn } } }
                )) {
                    Text("Share LinkedIn")
                }
                Toggle(isOn: Binding(
                    get: { selectedInfo.contains(.githubURL) },
                    set: { if $0 { selectedInfo.append(.githubURL) } else { selectedInfo.removeAll { $0 == .githubURL } } }
                )) {
                    Text("Share GitHub URL")
                }
                Toggle(isOn: Binding(
                    get: { selectedInfo.contains(.businessInfo) },
                    set: { if $0 { selectedInfo.append(.businessInfo) } else { selectedInfo.removeAll { $0 == .businessInfo } } }
                )) {
                    Text("Share Business Info")
                }
            }
            Button(action: {
                // Share the selected information
                userViewModel.shareContact(info: selectedInfo)
            }) {
                Text("Share Selected Information")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}
