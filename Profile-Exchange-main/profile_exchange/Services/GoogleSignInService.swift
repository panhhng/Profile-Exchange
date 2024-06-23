import Foundation
import GoogleSignIn

class GoogleSignInService {
    static func signIn(viewController: UIViewController, completion: @escaping (Result<User, Error>) -> Void) {
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController, completion: { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let result = result {
                let newUser = User(
                    id: result.user.userID ?? UUID().uuidString,
                    name: result.user.profile?.name ?? "Unknown",
                    email: result.user.profile?.email ?? "Unknown",
                    defaultShare: []
                )
                completion(.success(newUser))
            } else {
                let error = NSError(domain: "GoogleSignInService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"])
                completion(.failure(error))
            }
        })
    }

    static func signOut() {
        GIDSignIn.sharedInstance.signOut()
    }
}
