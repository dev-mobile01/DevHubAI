//
//  GitHubAPI.swift
//  DevHubAIApp
//
//  Created by ESI on 6/15/26.
//

import Foundation

final class GitHubAPI {

    func fetchUser(
        username: String
    ) async throws -> GitHubUser {

        let url = URL(
            string: "https://api.github.com/users/\(username)"
        )!

        let (data, _) = try await URLSession.shared.data(
            from: url
        )

        return try JSONDecoder().decode(
            GitHubUser.self,
            from: data
        )
    }
    
    func fetchRepositories(
        username: String
    ) async throws -> [GitHubRepository] {

        let url = URL(
            string: "https://api.github.com/users/\(username)/repos"
        )!

        let (data, _) = try await URLSession.shared.data(
            from: url
        )

        return try JSONDecoder().decode(
            [GitHubRepository].self,
            from: data
        )
    }
}
