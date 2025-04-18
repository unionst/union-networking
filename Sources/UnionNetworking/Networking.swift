//
//  Networking.swift
//  union-networking
//
//  Created by Ben Sage on 4/18/25.
//

import Foundation

public actor Networking {
    public static var baseURL: URL?

    public static func url(_ path: String) -> URL {
        guard let baseURL else {
            fatalError("Can't create network URL without setting baseURL.")
        }
        return baseURL.appending(path: path)
    }

    public static func components(_ path: String) -> URLComponents {
        let url = url(path)
        return .init(url: url, resolvingAgainstBaseURL: false) ?? URLComponents()
    }

    public static func request(_ endpoint: String) -> URLRequest {
        let url = url(endpoint)
        return URLRequest(url: url)
    }

    public static func request(endpoint: String, params: [String: String]) -> URLRequest {
        var components = components(endpoint)
        components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        if let url = components.url {
            return URLRequest(url: url)
        } else {
            return URLRequest(url: url(endpoint))
        }
    }
}
