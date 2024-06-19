import Foundation
import GoogleSignIn

class GoogleSignInService {
    static func signIn(viewController: UIViewController, completion: @escaping (Result<User, Error>) -> Void) {
        GIDSignIn.sharedInstance.signIn(with: viewController) { user, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = user {
                let newUser = User(
                    id: user.userID ?? UUID().uuidString,
                    name: user.profile?.name ?? "Unknown",
                    email: user.profile?.email ?? "Unknown",
                    defaultShare: []
                )
                completion(.success(newUser))
            } else {
                let error = NSError(domain: "GoogleSignInService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"])
                completion(.failure(error))
            }
        }
    }

    static func signOut() {
        GIDSignIn.sharedInstance.signOut()
    }
}
