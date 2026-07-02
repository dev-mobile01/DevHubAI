//
//  GitHubService.swift
//  DevHubAIApp
//
//  Created by ESI on 6/25/26.
//

import Foundation

protocol GitHubService {

    func fetchUser(
        username: String
    ) async throws -> GitHubUser

    func fetchRepositories(
        username: String,
        page: Int,
        perPage: Int
    ) async throws -> [GitHubRepository]
}
