import CoreNFC
import SwiftUI

class NFCManager: NSObject, ObservableObject, NFCNDEFReaderSessionDelegate {
    private var session: NFCNDEFReaderSession?
    var userToShare: User?
    
    func startSession(user: User?) {
        userToShare = user
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("NFC Session Invalidated: \(error.localizedDescription)")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        guard let user = userToShare else { return }
        
        var records = [NFCNDEFPayload]()
        
        for info in user.defaultShare {
            switch info {
            case .email:
                if let emailPayload = NFCNDEFPayload.wellKnownTypeURIPayload(string: "mailto:\(user.email)") {
                    records.append(emailPayload)
                }
            case .secondaryEmail:
                if let secondaryEmail = user.secondaryEmail,
                   let secondaryEmailPayload = NFCNDEFPayload.wellKnownTypeTextPayload(string: secondaryEmail, locale: <#Locale#>) {
                    records.append(secondaryEmailPayload)
                }
            case .linkedIn:
                if let linkedIn = user.linkedIn,
                   let linkedInPayload = NFCNDEFPayload.wellKnownTypeURIPayload(string: "https://linkedin.com/in/\(linkedIn)") {
                    records.append(linkedInPayload)
                }
            case .githubURL:
                if let githubURL = user.githubURL,
                   let githubPayload = NFCNDEFPayload.wellKnownTypeURIPayload(string: "https://github.com/\(githubURL)") {
                    records.append(githubPayload)
                }
            case .businessInfo:
                if let businessInfo = user.businessInfo,
                   let businessPayload = NFCNDEFPayload.wellKnownTypeTextPayload(string: businessInfo, locale: <#Locale#>) {
                    records.append(businessPayload)
                }
            }
        }
        
        let message = NFCNDEFMessage(records: records)
                session.alertMessage = "Hold your iPhone near another device to share contact information."
                
                guard let firstRecord = messages.first?.records.first else {
                    print("No NFC records found.")
                    return
                }
                
        session.connect(to: firstRecord as! NFCNDEFTag, completionHandler: { (error) in
                    if let error = error {
                        print("Error connecting to NFC tag: \(error.localizedDescription)")
                    }
                })    }
}

    

