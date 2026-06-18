//
//  RepositoryDetailView.swift
//  DevHubAIApp
//
//  Created by ESI on 6/17/26.
//

import SwiftUI

struct RepositoryDetailView: View {

    let repository: GitHubRepository

    var body: some View {

        List {

            Section("Repository") {

                Text(repository.name)
                    .font(.headline)

                if let description = repository.description {

                    Text(description)
                }
            }

            Section("Statistics") {

                HStack {

                    Label(
                        "\(repository.stargazersCount)",
                        systemImage: "star.fill"
                    )

                    Spacer()

                    Label(
                        "\(repository.forksCount)",
                        systemImage: "tuningfork"
                    )
                }
            }

            Section("Language") {

                Text(
                    repository.language ?? "Unknown"
                )
            }
        }
        .navigationTitle(
            repository.name
        )
        .navigationBarTitleDisplayMode(
            .inline
        )
    }
}
