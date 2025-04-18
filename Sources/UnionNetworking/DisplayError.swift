//
//  DisplayError.swift
//  union-networking
//
//  Created by Ben Sage on 4/18/25.
//

import Foundation

public struct DisplayError: Error, Equatable, LocalizedError {
    var message: String?

    public init(_ message: String?) {
        self.message = message
    }

    public var errorDescription: String? { message }
}

extension DisplayError {
    init(data: Data, response: HTTPURLResponse) {
        do {
            let response = try JSONDecoder().decode(ErrorResponse.self, from: data)
            self = .init(response.message)
        } catch {
            self = .init("Server error without message.")
        }
    }
}

extension DisplayError {
    static let notHTTP = DisplayError("Response was not HTTP.")

    static func notOK(_ statusCode: Int) -> DisplayError {
        .init("Response status code was not 2xx: \(statusCode).")
    }

    static let forbidden = DisplayError("Forbidden.")

    static let notFound = DisplayError("Not found.")
}

extension DisplayError {
    public static func ~=(pattern: DisplayError, value: Error) -> Bool {
        guard let value = value as? DisplayError else {
            return false
        }
        return pattern == value
    }
}
