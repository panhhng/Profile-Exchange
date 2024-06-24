import Foundation

struct User: Identifiable, Codable {
    var id: String
    var name: String
    var email: String
    var secondaryEmail: String?
    var linkedIn: String?
    var githubURL: String?
    var businessInfo: String?
    var defaultShare: [ContactInfo]
}

enum ContactInfo: String, Codable {
    case email
    case secondaryEmail
    case linkedIn
    case githubURL
    case businessInfo
}
