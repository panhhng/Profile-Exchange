//import UIKit
//import Firebase
//import GoogleSignIn
//import CoreData
//
//@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate {
//    var window: UIWindow?
//
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Configure Firebase
//        FirebaseApp.configure()
//        
//        // Set Google Sign-In configuration
//        if let clientID = FirebaseApp.app()?.options.clientID {
//            GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
//        }
//        
//        return true
//    }
//
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        // Handle URL scheme for Google Sign-In
//        return GIDSignIn.sharedInstance.handle(url)
//    }
//}
//
//import UIKit
//import Firebase
//import GoogleSignIn
//import CoreData
//
//class SignInViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Ensure Firebase is configured
//        guard let clientID = FirebaseApp.app()?.options.clientID else {
//            fatalError("Firebase not configured properly")
//        }
//        
//        // Set Google Sign-In configuration
//        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
//        
//        // Add a Google Sign-In button
//        let signInButton = GIDSignInButton()
//        signInButton.center = view.center
//        view.addSubview(signInButton)
//        
//        // Optional: Add a manual sign-in button
//        let manualSignInButton = UIButton(type: .system)
//        manualSignInButton.setTitle("Sign In with Google", for: .normal)
//        manualSignInButton.addTarget(self, action: #selector(signInWithGoogle), for: .touchUpInside)
//        manualSignInButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
//        manualSignInButton.center = CGPoint(x: view.center.x, y: view.center.y + 50)
//        view.addSubview(manualSignInButton)
//    }
//    
//    @objc func signInWithGoogle(_ sender: Any) {
//        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
//            if let error = error {
//                print("Error during sign-in: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let signInResult = signInResult else { return }
//            guard let user = signInResult.user else { return }
//            user.authentication.do { authentication, error in
//                if let error = error {
//                    print("Error retrieving authentication: \(error.localizedDescription)")
//                    return
//                }
//                
//                guard let authentication = authentication else { return }
//                let idToken = authentication.idToken
//                let accessToken = authentication.accessToken
//                
//                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
//                Auth.auth().signIn(with: credential) { authResult, error in
//                    if let error = error {
//                        print("Error during Firebase sign-in: \(error.localizedDescription)")
//                        return
//                    }
//                    // User is s
//
//
//
//
//class DataManager {
//    static let shared = DataManager()
//    let persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "Model")
//        container.loadPersistentStores { description, error in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        }
//        return container
//    }()
//    
//    func saveContext() {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
//}
