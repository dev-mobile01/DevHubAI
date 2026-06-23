//
//  ErrorStateView.swift
//  DevHubAIApp
//
//  Created by ESI on 6/23/26.
//

import SwiftUI

struct ErrorStateView: View {

    let message: String

    var body: some View {

        ContentUnavailableView(
            message,
            systemImage:
                "exclamationmark.triangle"
        )
    }
}
