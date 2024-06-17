import UIKit
import CoreNFC
import Firebase

class NFCExchangeViewController: UIViewController, NFCNDEFReaderSessionDelegate, NFCNDEFWriterSessionDelegate {

    var nfcReaderSession: NFCNDEFReaderSession?
    var nfcWriterSession: NFCNDEFWriterSession?

    override func viewDidLoad() {
        super.viewDidLoad()
        // UI setup and other initializations if necessary
    }

    @IBAction func startNFCSession(_ sender: Any) {
        let alertController = UIAlertController(title: "NFC", message: "Select action", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Read", style: .default, handler: { _ in
            self.startNFCReading()
        }))
        
        alertController.addAction(UIAlertAction(title: "Write", style: .default, handler: { _ in
            self.startNFCWriting()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }

    func startNFCReading() {
        guard NFCNDEFReaderSession.readingAvailable else {
            // NFC is not available on this device
            showAlert("Error", message: "NFC is not available on this device")
            return
        }
        nfcReaderSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcReaderSession?.begin()
    }

    func startNFCWriting() {
        guard NFCNDEFReaderSession.readingAvailable else {
            // NFC is not available on this device
            showAlert("Error", message: "NFC is not available on this device")
            return
        }
        // Fetch user data to write
        FirestoreManager.shared.getUserData { userData, error in
            if let error = error {
                self.showAlert("Error", message: error.localizedDescription)
                return
            }
            guard let userData = userData else {
                self.showAlert("Error", message: "No user data available")
                return
            }
            self.startWritingData(userData)
        }
    }

    func startWritingData(_ data: [String: Any]) {
        nfcWriterSession = NFCNDEFWriterSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcWriterSession?.begin()

        let jsonData = try? JSONSerialization.data(withJSONObject: data, options: [])
        guard let jsonString = String(data: jsonData!, encoding: .utf8) else {
            showAlert("Error", message: "Data formatting error")
            return
        }
        
        let payload = NFCNDEFPayload(format: .nfcWellKnown, type: Data(), identifier: Data(), payload: Data(jsonString.utf8))
        let message = NFCNDEFMessage(records: [payload])
        nfcWriterSession?.writeNDEF(message)
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        // Handle session invalidation
        showAlert("Error", message: error.localizedDescription)
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        if let message = messages.first {
            for record in message.records {
                if let data = record.payload as? Data,
                   let info = String(data: data, encoding: .utf8) {
                    handleReceivedData(info)
                }
            }
        }
    }

    func handleReceivedData(_ data: String) {
        // Parse JSON data
        guard let jsonData = data.data(using: .utf8),
              let receivedData = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
            showAlert("Error", message: "Received data parsing error")
            return
        }
        // Save received data to Firestore
        guard let userId = Auth.auth().currentUser?.uid else { return }
        FirestoreManager.shared.saveSharedContact(receivedData, forUserId: userId)
    }

    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
