//
//  EmptyStateView.swift
//  DevHubAIApp
//
//  Created by ESI on 6/23/26.
//

import SwiftUI

struct EmptyStateView: View {

    let title: String

    let message: String

    let systemImage: String

    var body: some View {

        ContentUnavailableView {

            Label(
                title,
                systemImage: systemImage
            )

        } description: {

            Text(message)
        }
    }
}
