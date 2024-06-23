import UIKit
import Firebase
import GoogleSignIn

class SignInViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the configuration
        if let clientID = FirebaseApp.app()?.options.clientID {
            GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
        } else {
            print("Error: Firebase client ID is nil")
            return
        }
        
        // Add a Google Sign-In button
        let signInButton = GIDSignInButton()
        signInButton.center = view.center
        view.addSubview(signInButton)
        
        // Add action for the button
        signInButton.addTarget(self, action: #selector(signInWithGoogle), for: .touchUpInside)
    }
    
    @objc func signInWithGoogle() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            if let error = error {
                print("Error during sign-in: \(error.localizedDescription)")
                return
            }
            
            guard let signInResult = signInResult else {
                print("No sign-in result")
                return
            }
            
            let user = signInResult.user
            
            guard let idToken = user.idToken?.tokenString else {
                print("No idToken found")
                return
            }
            
            let accessToken = user.accessToken.tokenString
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Error during Firebase sign-in: \(error.localizedDescription)")
                    return
                }
                // User is signed in
                print("User signed in with Google: \(String(describing: authResult?.user.displayName))")
            }
        }
    }
}
