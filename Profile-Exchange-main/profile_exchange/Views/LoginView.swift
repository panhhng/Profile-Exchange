import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        VStack {
            Text("Welcome to Contact Sharing App")
                .font(.largeTitle)
                .padding()
            Button(action: {
                // Call signInWithGoogle method from UserViewModel
                userViewModel.signInWithGoogle()
            }) {
                Text("Sign in with Google")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}
