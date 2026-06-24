//
//  DashboardView.swift
//  DevHubAIApp
//
//  Created by ESI on 6/15/26.
//

import SwiftUI

struct DashboardView: View {

    @State
    private var viewModel = DashboardViewModel()

    var body: some View {

        NavigationStack {

            VStack {

                // Content Section

                Group {

                    if viewModel.isLoading {

                        LoadingView()

                    } else if let error = viewModel.errorMessage {

                        ErrorStateView(
                            message: error
                        )

                    } else if let user = viewModel.user {

                        ScrollView {

                            VStack(spacing: 20) {

                                AsyncImage(
                                    url: URL(string: user.avatarUrl)
                                ) { image in

                                    image
                                        .resizable()
                                        .scaledToFill()

                                } placeholder: {

                                    LoadingView()
                                }
                                .frame(
                                    width: 120,
                                    height: 120
                                )
                                .clipShape(Circle())

                                Text(
                                    user.name ?? "Unknown"
                                )
                                .font(.title)

                                Text(
                                    "@\(user.login)"
                                )
                                .foregroundStyle(.secondary)

                                DashboardCard {

                                    HStack {

                                        VStack {

                                            Text(
                                                "\(user.publicRepos)"
                                            )
                                            .bold()

                                            Text("Repos")
                                        }

                                        Spacer()

                                        VStack {

                                            Text(
                                                "\(user.followers)"
                                            )
                                            .bold()

                                            Text("Followers")
                                        }

                                        Spacer()

                                        VStack {

                                            Text(
                                                "\(user.following)"
                                            )
                                            .bold()

                                            Text("Following")
                                        }
                                    }
                                }
                                
                                if !viewModel.repositories.isEmpty {

                                    VStack(
                                        alignment: .leading,
                                        spacing: 12
                                    ) {

                                        Text("Repositories")
                                            .font(.title2)
                                            .bold()

                                        TextField(
                                            "Search repositories",
                                            text: $viewModel.repositorySearchText
                                        )
                                        .textFieldStyle(
                                            .roundedBorder
                                        )
                                        
                                        if viewModel.filteredRepositories.isEmpty {

                                            EmptyStateView(
                                                title: "No Results",
                                                message:
                                                    "No repositories match your search.",
                                                systemImage:
                                                    "magnifyingglass"
                                            )

                                        } else {

                                            ForEach(viewModel.filteredRepositories) { repository in

                                                NavigationLink {

                                                    RepositoryDetailView(
                                                        repository: repository
                                                    )

                                                } label: {

                                                    RepositoryRow(
                                                        repository: repository
                                                    )
                                                }

                                                Divider()
                                            }
                                        }
                                        
                                    }

                                } else if viewModel.user != nil {

                                    EmptyStateView(
                                        title: "No Repositories",
                                        message: "This GitHub user has no public repositories.",
                                        systemImage: "folder"
                                    )
                                }
                            }
                            .padding()
                        }

                    } else {

                        EmptyStateView(
                            title: "Welcome",
                            message: "Search a GitHub user",
                            systemImage: "magnifyingglass"
                        )
                    }
                }

                Spacer()
            }
            .navigationTitle("Dashboard")
        }
        .searchable(
            text: $viewModel.username,
            prompt: "Search GitHub User"
        )
        .onChange(
            of: viewModel.username
        ) {

            viewModel.searchWithDebounce()
        }
        .onSubmit(of: .search) {

            Task {
                await viewModel.search()
            }
        }
    }
}
