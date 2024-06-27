//
//  AppDelegate.swift
//  profile-exchange
//
//  Created by Nhân Nguyễn on 6/26/24.
//

//import FirebaseCore
//import UIKit
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//
//        return true
//    }
//}

//import UIKit
//import Firebase
//import GoogleSignIn
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
//        // Configure Google Sign-In
//        if let clientID = FirebaseApp.app()?.options.clientID {
//            GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
//        } else {
//            print("Error: Firebase client ID is nil")
//        }
//
//        return true
//    }
//
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        return GIDSignIn.sharedInstance.handle(url)
//    }
//}

//import UIKit
//import Firebase
//
//@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    var window: UIWindow?
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//}

//@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    var window: UIWindow?
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        
//        FirebaseApp.configure() // Ensure Firebase is configured
//        
//        // Create UIWindow
//        window = UIWindow(frame: UIScreen.main.bounds)
//        
//        // Set up SignInViewController as the root view controller
//        let signInViewController = SignInViewController()
//        let navigationController = UINavigationController(rootViewController: signInViewController)
//        window?.rootViewController = navigationController
//        
//        // Make window visible
//        window?.makeKeyAndVisible()
//        
//        return true
//    }
//}

/*enable analytic data collection*/
//import UIKit
//import Firebase
//import FirebaseMessaging
//
//@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
//
//    var window: UIWindow?
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        
//        FirebaseApp.configure() // Ensure Firebase is configured
//        
//        // Enable Firebase Analytics (Optional if not enabled already)
//        Analytics.logEvent(AnalyticsEventAppOpen, parameters: nil)
//        
//        // Set Messaging delegate
//        Messaging.messaging().delegate = self
//        
//        // Other initialization code as needed
//        
//        // Create UIWindow
//        window = UIWindow(frame: UIScreen.main.bounds)
//        
//        // Set up SignInViewController as the root view controller
//        let signInViewController = SignInViewController()
//        let navigationController = UINavigationController(rootViewController: signInViewController)
//        window?.rootViewController = navigationController
//        
//        // Make window visible
//        window?.makeKeyAndVisible()
//        
//        return true
//    }
//    
//    // MARK: - MessagingDelegate Methods
//    
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        // Handle new FCM token received
//        print("Firebase registration token: \(String(describing: fcmToken))")
//        
//        // Note: This method is called whenever a new token is generated or existing token is refreshed.
//        // Use this method to subscribe to any topics, send this token to your server, etc.
//    }
//}

import UIKit
import Firebase
import UserNotifications
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Configure Firebase
        FirebaseApp.configure()

        // Set UNUserNotificationCenter delegate
        UNUserNotificationCenter.current().delegate = self

        // Register for remote notifications
        application.registerForRemoteNotifications()

        // Request authorization for notifications
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in }

        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Pass device token to Messaging
        Messaging.messaging().apnsToken = deviceToken
    }

    // Handle foreground notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print("Message ID: \(userInfo["gcm.message_id"]!)")
        print(userInfo)

        completionHandler([.alert, .badge, .sound])
    }

    // Handle background notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("Message ID: \(userInfo["gcm.message_id"]!)")
        print(userInfo)

        completionHandler()
    }

    // Handle refreshed FCM token
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
    }
}
