//
//  ErrorDisplayable.swift
//  union-networking
//
//  Created by Ben Sage on 4/27/25.
//

import Foundation

public protocol ErrorDisplayable: AnyObject {
    @MainActor var error: String? { get set }
}

extension ErrorDisplayable {
    @MainActor
    public func showError(_ error: Error) {
        if let error = error as? DisplayError {
            self.error = error.message
        } else if error is CancellationError {
            return
        } else if let decodingError = error as? DecodingError {
            #if DEBUG
            let message = decodingError.prettyDescription
            self.error = message
            print(message)
            #else
            self.error = "An error occurred."
            #endif
        } else {
            #if DEBUG
            self.error = error.localizedDescription
            print(error.localizedDescription)
            #else
            self.error = "An error occurred."
            #endif
        }
    }

    @MainActor
    public func tryAndShow(_ operation: @Sendable @MainActor () async throws -> Void) async {
        do {
            try await operation()
        } catch {
            showError(error)
        }
    }
}
