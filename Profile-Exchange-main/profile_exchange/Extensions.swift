//import Foundation
//import CoreNFC
//
//extension NFCNDEFPayload {
//    static func wellKnownTypeURIPayload(string: String) -> NFCNDEFPayload? {
//        guard let payloadData = string.data(using: .utf8) else { return nil }
//        return NFCNDEFPayload(format: .uri, type: "U", identifier: Data(), payload: payloadData)
//    }
//
//    static func wellKnownTypeTextPayload(string: String) -> NFCNDEFPayload? {
//        let locale = Locale(identifier: "en_US")
//        let payloadData = string.data(using: .utf8)!
//        return NFCNDEFPayload.wellKnownTypeTextPayload(payload: payloadData, locale: locale)
//    }
//}
//a
