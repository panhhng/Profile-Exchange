import SwiftUI
import GoogleSignIn

struct ContentView: View {
    @StateObject private var userViewModel = UserViewModel()

    var body: some View {
        if userViewModel.isLoggedIn {
            HomeView()
                .environmentObject(userViewModel)
        } else {
            LoginView()
                .environmentObject(userViewModel)
        }
    }
}
