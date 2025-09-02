//
//  RedirectPreservingDelegate.swift
//  union-networking
//
//  Created by Aaron Moss on 9/2/25.
//

import Foundation

final class RedirectPreservingDelegate: NSObject, URLSessionTaskDelegate {
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    willPerformHTTPRedirection response: HTTPURLResponse,
                    newRequest request: URLRequest,
                    completionHandler: @escaping (URLRequest?) -> Void) {
        guard let original = task.originalRequest else {
            completionHandler(request)
            return
        }

        let statusCode = response.statusCode
        guard statusCode == 307 || statusCode == 308 else {
            completionHandler(request)
            return
        }

        let sameOrigin =
            original.url?.scheme == request.url?.scheme &&
            original.url?.host == request.url?.host &&
            original.url?.port == request.url?.port
        guard sameOrigin else {
            completionHandler(request)
            return
        }

        var redirected = request
        redirected.httpMethod = original.httpMethod

        if let body = original.httpBody {
            redirected.httpBody = body
        }

        if let headers = original.allHTTPHeaderFields {
            for (key, value) in headers {
                redirected.setValue(value, forHTTPHeaderField: key)
            }
        }

        completionHandler(redirected)
    }
}


