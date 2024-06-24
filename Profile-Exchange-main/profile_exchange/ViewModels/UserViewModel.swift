import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var isLoggedIn: Bool = false

    private var cancellables: Set<AnyCancellable> = []

    init() {
        // Load user from persistence
        loadUser()
    }

    func signInWithGoogle() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            print("Unable to find root view controller.")
            return
        }

        GoogleSignInService.signIn(viewController: rootViewController) { [weak self] result in
            switch result {
            case .success(let user):
                self?.currentUser = user
                self?.isLoggedIn = true
                self?.saveUser(user)
            case .failure(let error):
                print("Google Sign In failed: \(error.localizedDescription)")
                self?.isLoggedIn = false
            }
        }
    }

    func signOut() {
        GoogleSignInService.signOut()
        currentUser = nil
        isLoggedIn = false
        clearUser()
    }

    func updateUser(_ user: User) {
        currentUser = user
        saveUser(user)
    }

    private func loadUser() {
        // Load user from persistence service
        if let savedUser = PersistenceService.loadUser() {
            currentUser = savedUser
            isLoggedIn = true
        }
    }

    private func saveUser(_ user: User) {
        PersistenceService.saveUser(user)
    }

    private func clearUser() {
        PersistenceService.clearUser()
    }

    func shareContact(info: [ContactInfo]) {
        guard let currentUser = currentUser else { return }
        var sharedContactInfo: [ContactInfo: String] = [:]

        if info.contains(.email) {
            sharedContactInfo[.email] = currentUser.email
        }
        if info.contains(.secondaryEmail), let secondaryEmail = currentUser.secondaryEmail {
            sharedContactInfo[.secondaryEmail] = secondaryEmail
        }
        if info.contains(.linkedIn), let linkedIn = currentUser.linkedIn {
            sharedContactInfo[.linkedIn] = linkedIn
        }
        if info.contains(.githubURL), let githubURL = currentUser.githubURL {
            sharedContactInfo[.githubURL] = githubURL
        }
        if info.contains(.businessInfo), let businessInfo = currentUser.businessInfo {
            sharedContactInfo[.businessInfo] = businessInfo
        }

        let contact = Contact(id: UUID().uuidString, userId: currentUser.id, sharedContactInfo: sharedContactInfo)
        PersistenceService.saveContacts([contact])
    }
}
