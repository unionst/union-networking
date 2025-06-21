//
//  DecodingError+LocalizedError.swift
//  Patrol
//
//  Created by Ben Sage on 3/28/25.
//

import Foundation

extension DecodingError {
    public var prettyDescription: String {
        switch self {
        case let .typeMismatch(type, context):
            "DecodingError.typeMismatch \(type), value \(context.prettyDescription) @ ERROR: \(localizedDescription)"
        case let .valueNotFound(type, context):
            "DecodingError.valueNotFound \(type), value \(context.prettyDescription) @ ERROR: \(localizedDescription)"
        case let .keyNotFound(key, context):
            "DecodingError.keyNotFound \(key), value \(context.prettyDescription) @ ERROR: \(localizedDescription)"
        case let .dataCorrupted(context):
            "DecodingError.dataCorrupted \(context.prettyDescription), @ ERROR: \(localizedDescription)"
        default:
            "DecodingError: \(localizedDescription)"
        }
    }
}

private extension DecodingError.Context {
    var prettyDescription: String {
        var result = ""
        if !codingPath.isEmpty {
            result.append(codingPath.map(\.stringValue).joined(separator: "."))
            result.append(": ")
        }
        result.append(debugDescription)
        if
            let nsError = underlyingError as? NSError,
            let description = nsError.userInfo["NSDebugDescription"] as? String
        {
            result.append(description)
        }
        return result
    }
}
