//
//  URLRequest+Util.swift
//  union-networking
//
//  Created by Ben Sage on 4/18/25.
//

import Foundation

extension URLRequest {
    mutating func addToken(_ token: String) async throws {
        setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }

    mutating func setJSON() {
        setValue("application/json", forHTTPHeaderField: "Content-Type")
    }

    mutating func setURLEncoded() {
        setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    }

    @discardableResult
    func execute(token: String) async throws -> Data {
        var request = self
        try await request.addToken(token)
        let (data, response) = try await URLSession.shared.data(for: request)
        try response.check(data: data)
        return data
    }

    func get<T: Decodable>(token: String) async throws -> T {
        let data = try await execute(token: token)

        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return try decoder.decode(T.self, from: data)
    }
}
