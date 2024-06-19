//import Firebase
//import GoogleSignIn
//
//class AuthService {
//    static let shared = AuthService()
//    
//    func signInWithGoogle(presenting: UIViewController, completion: @escaping (Result<User, Error>) -> Void) {
//        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = config
//
//        GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { user, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let authentication = user?.authentication, let idToken = authentication.idToken else {
//                completion(.failure(NSError(domain: "SignIn", code: -1, userInfo: nil)))
//                return
//            }
//
//            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
//
//            Auth.auth().signIn(with: credential) { authResult, error in
//                if let error = error {
//                    completion(.failure(error))
//                    return
//                }
//
//                guard let user = authResult?.user else {
//                    completion(.failure(NSError(domain: "SignIn", code: -1, userInfo: nil)))
//                    return
//                }
//
//                completion(.success(user))
//            }
//        }
//    }
//}
