//
//  LoadingView.swift
//  DevHubAIApp
//
//  Created by ESI on 6/23/26.
//

import SwiftUI

struct LoadingView: View {

    var body: some View {

        VStack(
            spacing: 16
        ) {

            ProgressView()

            Text(
                "Loading..."
            )
            .foregroundStyle(
                .secondary
            )
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }
}
