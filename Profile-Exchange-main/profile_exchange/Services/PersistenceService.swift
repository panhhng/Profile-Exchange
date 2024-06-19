import Foundation

class PersistenceService {
    static let userKey = "savedUser"
    static let contactsKey = "sharedContacts"

    static func saveUser(_ user: User) {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: userKey)
        }
    }

    static func loadUser() -> User? {
        if let data = UserDefaults.standard.data(forKey: userKey),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            return user
        }
        return nil
    }

    static func clearUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
    }

    static func saveContacts(_ contacts: [Contact]) {
        if let data = try? JSONEncoder().encode(contacts) {
            UserDefaults.standard.set(data, forKey: contactsKey)
        }
    }

    static func loadContacts() -> [Contact] {
        if let data = UserDefaults.standard.data(forKey: contactsKey),
           let contacts = try? JSONDecoder().decode([Contact].self, from: data) {
            return contacts
        }
        return []
    }
}
