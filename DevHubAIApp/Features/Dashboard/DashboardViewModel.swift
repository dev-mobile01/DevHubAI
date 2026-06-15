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

        } catch {

            user = nil
            errorMessage = "User not found"
        }
    }
}
