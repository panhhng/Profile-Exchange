import SwiftUI

struct ShareContactView: View {
    @EnvironmentObject var nfcManager: NFCManager
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        VStack {
            Text("Bring the phones close to share contact")
                .font(.title2)
                .padding()
            Button(action: {
                nfcManager.startSession(user: userViewModel.currentUser)
            }) {
                Text("Start NFC Session")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}
