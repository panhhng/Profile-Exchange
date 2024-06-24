import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        VStack {
            Text("Profile")
                .font(.largeTitle)
                .padding()
            EditProfileView()
                .environmentObject(userViewModel)
            Spacer()
        }
        .padding()
    }
}
