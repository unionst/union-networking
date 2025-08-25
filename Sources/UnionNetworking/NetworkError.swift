//
//  NetworkError.swift
//  union-networking
//
//  Created by Ben Sage on 4/18/25.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case httpError(statusCode: Int, serverMessage: String?, data: Data?)
    case notHTTPResponse
    case networkFailure(Error)
    
    public var errorDescription: String? {
        switch self {
        case .httpError(let statusCode, let serverMessage, _):
            if let serverMessage = serverMessage {
                return serverMessage
            } else if statusCode == 401 {
                return "Forbidden."
            } else if statusCode == 404 {
                return "Not found."
            } else {
                return "Response status code was not 2xx: \(statusCode)."
            }
        case .notHTTPResponse:
            return "Response was not HTTP."
        case .networkFailure(let error):
            return error.localizedDescription
        }
    }
}
