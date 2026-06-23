//
//  RepositoryDetailView.swift
//  DevHubAIApp
//
//  Created by ESI on 6/17/26.
//

import SwiftUI
import SwiftData

struct RepositoryDetailView: View {

    let repository: GitHubRepository

    @Environment(\.modelContext)
    private var modelContext
    
    @Query
    private var favorites: [FavoriteRepository]
        
    private var isFavorite: Bool {

        favorites.contains {
            $0.id == repository.id
        }
    }
    
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
            
            Section("Actions") {

                Link(
                    "Open in GitHub",
                    destination: URL(
                        string: repository.htmlUrl
                    )!
                )

                ShareLink(
                    item: repository.htmlUrl
                ) {

                    Label(
                        "Share Repository",
                        systemImage: "square.and.arrow.up"
                    )
                }
                
                Button {

                    UIPasteboard.general.string =
                        repository.htmlUrl

                } label: {

                    Label(
                        "Copy URL",
                        systemImage: "doc.on.doc"
                    )
                }
            }
            
            Section {

                Button {

                    if isFavorite {

                        if let favorite = favorites.first(
                            where: {
                                $0.id == repository.id
                            }
                        ) {

                            modelContext.delete(
                                favorite
                            )
                        }

                    } else {

                        let favorite = FavoriteRepository(

                            id: repository.id,

                            name: repository.name,

                            repositoryDescription:
                                repository.description ?? "",

                            language:
                                repository.language ?? "Unknown"
                        )

                        modelContext.insert(
                            favorite
                        )
                    }

                } label: {

                    Label(

                        isFavorite
                            ? "Remove Favorite"
                            : "Add To Favorites",

                        systemImage:

                        isFavorite
                            ? "star.slash"
                            : "star.fill"
                    )
                }
                .tint(
                    isFavorite
                    ? .red
                    : .yellow
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
