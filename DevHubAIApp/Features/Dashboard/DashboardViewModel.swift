//
//  DashboardViewModel.swift
//  DevHubAIApp
//
//  Created by ESI on 6/15/26.
//

import Foundation
import Observation

@Observable
final class DashboardViewModel {

    var username = ""

    var user: GitHubUser?

    var isLoading = false

    var errorMessage: String?

    var repositories: [GitHubRepository] = []
    
    private var searchTask: Task<Void, Never>?
    
    private let service: GitHubService

    var repositorySearchText = ""
    
    var selectedSort: RepositorySortOption = .name
    
    var currentPage = 1

    var hasMorePages = true

    var isLoadingMore = false
    
    var filteredRepositories: [GitHubRepository] {

        let filtered: [GitHubRepository]

        if repositorySearchText.isEmpty {

            filtered = repositories

        } else {

            filtered = repositories.filter {

                $0.name.localizedCaseInsensitiveContains(
                    repositorySearchText
                )
            }
        }

        switch selectedSort {

        case .name:

            return filtered.sorted {
                $0.name < $1.name
            }

        case .stars:

            return filtered.sorted {
                $0.stargazersCount > $1.stargazersCount
            }

        case .forks:

            return filtered.sorted {
                $0.forksCount > $1.forksCount
            }
        }
    }
    
    init(
        service: GitHubService = GitHubAPI()
    ) {
        self.service = service
    }
    
    func search() async {

        guard username.count > 2 else {
            return
        }
        
        guard !username.isEmpty else {
            return
        }

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {

            user = try await service.fetchUser(
                username: username
            )

            repositories = try await service.fetchRepositories(
                username: username,
                page: 1,
                perPage: 50
            )

        } catch {

            user = nil

            repositories = []

            errorMessage = "User not found"
        }
    }
    
    func searchWithDebounce() {

        searchTask?.cancel()

        searchTask = Task {

            try? await Task.sleep(
                for: .milliseconds(700)
            )

            guard !Task.isCancelled else {
                return
            }

            await search()
        }
    }
}
