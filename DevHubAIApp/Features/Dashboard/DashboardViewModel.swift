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
    
    func search() async {

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
}
