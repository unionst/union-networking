//
//  URLRequest+Util.swift
//  union-networking
//
//  Created by Ben Sage on 4/18/25.
//

import Foundation
import UnionKeychain

public extension URLRequest {
    mutating func addToken(_ token: String?) {
        if let token {
            setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }

    mutating func addToken() {
        if let token = Keychain.bearerToken {
            addToken(token)
        }
    }

    mutating func setJSON() {
        setValue("application/json", forHTTPHeaderField: "Content-Type")
    }

    mutating func setURLEncoded() {
        setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    }

    @discardableResult
    func execute(preserveHeadersOnRedirect: Bool = false) async throws -> Data {
        let session = preserveHeadersOnRedirect ? URLSession(configuration: .default, delegate: RedirectPreservingDelegate(), delegateQueue: nil) : URLSession.shared
        return try await execute(using: session)
    }

    @discardableResult
    private func execute(using session: URLSession) async throws -> Data {
        let request = self
        let (data, response) = try await session.data(for: request)
        try response.check(data: data)
        return data
    }

    func get<T: Decodable>(preserveHeadersOnRedirect: Bool = false) async throws -> T {
        let data = try await execute(preserveHeadersOnRedirect: preserveHeadersOnRedirect)

        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return try decoder.decode(T.self, from: data)
    }
}
