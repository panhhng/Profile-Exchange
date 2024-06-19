import CoreNFC

class NFCService: NSObject, NFCNDEFReaderSessionDelegate {
    private var readerSession: NFCNDEFReaderSession?
    var completion: ((Result<NFCNDEFMessage, Error>) -> Void)?
    private var ndefMessageToWrite: NFCNDEFMessage?

    func startSession(completion: @escaping (Result<NFCNDEFMessage, Error>) -> Void) {
        self.completion = completion
        readerSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        readerSession?.begin()
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        completion?(.failure(error))
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        if let message = messages.first {
            completion?(.success(message))
        }
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        guard let tag = tags.first else { return }
        
        session.connect(to: tag) { error in
            if let error = error {
                session.invalidate(errorMessage: "Connection failed: \(error.localizedDescription)")
                return
            }
            
            tag.queryNDEFStatus { status, _, error in
                if let error = error {
                    session.invalidate(errorMessage: "Query failed: \(error.localizedDescription)")
                    return
                }
                
                if status == .readWrite {
                    guard let message = self.ndefMessageToWrite else {
                        session.invalidate(errorMessage: "No message to write")
                        return
                    }
                    
                    tag.writeNDEF(message) { error in
                        if let error = error {
                            session.invalidate(errorMessage: "Write failed: \(error.localizedDescription)")
                        } else {
                            session.alertMessage = "Write successful"
                            session.invalidate()
                        }
                    }
                } else {
                    session.invalidate(errorMessage: "Tag is not writable")
                }
            }
        }
    }

    func sendNFCMessage(_ message: NFCNDEFMessage) {
        self.ndefMessageToWrite = message
        readerSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        readerSession?.begin()
    }
}
