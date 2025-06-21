//
//  View+ErrorAlert.swift
//  union-networking
//
//  Created by Ben Sage on 4/27/25.
//

import SwiftUI

public extension View {
    func errorAlert<O: ErrorDisplayable>(_ object: O) -> some View {
        alert(
            "Error",
            isPresented: .init(
                get: { object.error != nil },
                set: { if !$0 { object.error = nil } }
            ),
            actions: {
                Button("OK", role: .cancel) { }
            },
            message: {
                if let message = object.error {
                    Text(message)
                }
            }
        )
    }
}
