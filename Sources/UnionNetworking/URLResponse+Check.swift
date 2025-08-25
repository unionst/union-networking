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
            throw NetworkError.notHTTPResponse
        }

        let statusCode = httpResponse.statusCode
        guard 200..<300 ~= statusCode else {
            let serverMessage = try? JSONDecoder().decode(ErrorResponse.self, from: data).message
            throw NetworkError.httpError(statusCode: statusCode, serverMessage: serverMessage, data: data)
        }
    }
}
