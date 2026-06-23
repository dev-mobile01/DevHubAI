//
//  DashboardCard.swift
//  DevHubAIApp
//
//  Created by ESI on 6/15/26.
//

import SwiftUI

struct DashboardCard<Content: View>: View {

    let content: Content

    init(
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
    }

    var body: some View {

        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(
                    cornerRadius: AppCornerRadius.large
                )
                .fill(AppColors.cardBackground)
            )
            .overlay {
                RoundedRectangle(
                    cornerRadius: AppCornerRadius.large
                )
                .stroke(.quaternary)
            }
            .shadow(
                color: .black.opacity(0.05),
                radius: 8,
                y: 2
            )
    }
}
