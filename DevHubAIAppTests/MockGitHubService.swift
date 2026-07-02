//
//  MockGitHubService.swift
//  DevHubAIApp
//
//  Created by ESI on 6/25/26.
//

import Foundation
@testable import DevHubAIApp

final class MockGitHubService: GitHubService {

    var user: GitHubUser
    var repositories: [GitHubRepository]

    var shouldThrowError = false

    init(
        user: GitHubUser,
        repositories: [GitHubRepository]
    ) {
        self.user = user
        self.repositories = repositories
    }

    func fetchUser(
        username: String
    ) async throws -> GitHubUser {

        if shouldThrowError {
            throw MockError.failed
        }

        return user
    }

    func fetchRepositories(
        username: String,
        page: Int,
        perPage: Int
    ) async throws -> [GitHubRepository] {

        if shouldThrowError {
            throw MockError.failed
        }

        return repositories
    }
}

enum MockError: Error {
    case failed
}
