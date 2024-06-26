//
//  NFCManager.swift
//  profile-exchange
//
//  Created by Nhân Nguyễn on 6/26/24.
//

import CoreNFC

class NFCManager: NSObject, NFCNDEFReaderSessionDelegate {
    static let shared = NFCManager()

    private var session: NFCNDEFReaderSession?
    private var onDetection: ((Result<String, Error>) -> Void)?

    func beginScanning(onDetection: @escaping (Result<String, Error>) -> Void) {
        self.onDetection = onDetection
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session?.begin()
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        onDetection?(.failure(error))
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        guard let message = messages.first else { return }
        guard let record = message.records.first else { return }
        guard let payload = String(data: record.payload, encoding: .utf8) else { return }
        onDetection?(.success(payload))
    }
}
