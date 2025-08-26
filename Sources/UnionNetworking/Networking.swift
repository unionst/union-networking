//
//  Networking.swift
//  union-networking
//
//  Created by Ben Sage on 4/18/25.
//

import Foundation

public actor Networking {
    public static let baseURL: URL = {
        guard
            let urlString = Bundle.main.object(forInfoDictionaryKey: "NetworkingBaseURL") as? String,
            let url = URL(string: urlString)
        else {
            fatalError("⚠️ NetworkingBaseURL not set in Info.plist")
        }
        return url
    }()

    public static func url(_ path: String) -> URL {
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

    public static func request(endpoint: String, params: [String: String], encodingCharSet: CharacterSet = .urlQueryAllowed) -> URLRequest {
        var components = components(endpoint)
        components.percentEncodedQuery = params.map {
            let encodedKey = $0.key.addingPercentEncoding(withAllowedCharacters: encodingCharSet) ?? $0.key
            let encodedValue = $0.value.addingPercentEncoding(withAllowedCharacters: encodingCharSet) ?? $0.value
            
            return "\(encodedKey)=\(encodedValue)"
        }.joined(separator: "&")
        
        if let url = components.url {
            return URLRequest(url: url)
        } else {
            return URLRequest(url: url(endpoint))
        }
    }
}
