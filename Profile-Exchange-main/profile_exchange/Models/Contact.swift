import Foundation

struct Contact: Identifiable, Codable {
    var id: String
    var userId: String
    var sharedContactInfo: [ContactInfo: String]
}
