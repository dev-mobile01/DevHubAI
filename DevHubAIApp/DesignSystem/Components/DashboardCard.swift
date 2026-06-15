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
            .background(AppColors.cardBackground)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: AppCornerRadius.large
                )
            )
    }
}
