import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @StateObject private var contactViewModel = ContactViewModel()

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ProfileView().environmentObject(userViewModel)) {
                    Text("View/Edit Profile")
                }
                NavigationLink(destination: ContactListView().environmentObject(contactViewModel)) {
                    Text("Shared Contacts")
                }
                NavigationLink(destination: ShareContactView().environmentObject(NFCManager()).environmentObject(userViewModel)) {
                    Text("Share Contact via NFC")
                }
            }
            .navigationTitle("Home")
            .toolbar {
                Button(action: {
                    userViewModel.signOut()
                }) {
                    Text("Sign Out")
                }
            }
        }
    }
}
