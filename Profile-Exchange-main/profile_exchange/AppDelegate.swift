import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // set up Firebase when app launches
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    // handle URL that app receives after Google Sign-in
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

class SignInViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up Google Sign-In by config with Firebase app's client ID
        let clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID!)
        
        // Add a Google Sign-In button
        let signInButton = GIDSignInButton()
        signInButton.center = view.center
        view.addSubview(signInButton)
    }
    
    // Handle Google Sign-In Process and use result to authenticate with Firebase
    @IBAction func signInWithGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            if let error = error {
                print("Error during sign-in: \(error.localizedDescription)")
                return
            }
            
            guard let signInResult = signInResult else { return }
            guard let idToken = signInResult.user.idToken?.tokenString else { return }
            let accessToken = signInResult.user.accessToken.tokenString
            
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


