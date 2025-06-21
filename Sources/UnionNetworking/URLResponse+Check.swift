//
//  URLResponse+Check.swift
//  union-networking
//
//  Created by Ben Sage on 4/18/25.
//

import Foundation

extension URLResponse {
    public func check(data: Data) throws {
        guard let httpResponse = self as? HTTPURLResponse else {
            throw DisplayError.notHTTP
        }

        let statusCode = httpResponse.statusCode
        guard 200..<300 ~= statusCode else {
            if statusCode == 401 {
                throw DisplayError.forbidden
            } else if statusCode == 404 {
                throw DisplayError.notFound
            } else if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                throw DisplayError(errorResponse.message)
            } else {
                throw DisplayError.notOK(statusCode)
            }
        }
    }
}
