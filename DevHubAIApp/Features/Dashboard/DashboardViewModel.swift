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

    private let api = GitHubAPI()

    var repositories: [GitHubRepository] = []
    
    private var searchTask: Task<Void, Never>?
    
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

            user = try await api.fetchUser(
                username: username
            )

            repositories = try await api.fetchRepositories(
                username: username
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
