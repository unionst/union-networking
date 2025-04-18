//
//  ErrorResponse.swift
//  union-networking
//
//  Created by Ben Sage on 4/18/25.
//

import Foundation

public struct ErrorResponse: Decodable {
    let message: String

    private enum CodingKeys: String, CodingKey {
        case message, error
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let msg = try? container.decode(String.self, forKey: .message) {
            message = msg
        } else if let msg = try? container.decode(String.self, forKey: .error) {
            message = msg
        } else {
            throw DecodingError.keyNotFound(
                CodingKeys.message,
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Expected key 'message' or 'error' not found."
                )
            )
        }
    }
}
