//
//  RepositoryRow.swift
//  DevHubAIApp
//
//  Created by ESI on 6/17/26.
//

import SwiftUI

struct RepositoryRow: View {

    let repository: GitHubRepository

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Text(repository.name)
                .font(.headline)

            if let description = repository.description {

                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            HStack {

                if let language = repository.language {

                    Text(language)
                        .font(.caption)
                }

                Spacer()

                Label(
                    "\(repository.stargazersCount)",
                    systemImage: "star.fill"
                )

                Label(
                    "\(repository.forksCount)",
                    systemImage: "tuningfork"
                )
            }
            .font(.caption)
        }
        .padding()
    }
}
