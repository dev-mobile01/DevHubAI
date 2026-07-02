//
//  GitHubAPI.swift
//  DevHubAIApp
//
//  Created by ESI on 6/15/26.
//

import Foundation

final class GitHubAPI: GitHubService {

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
        username: String,
        page: Int = 1,
        perPage: Int = 20
    ) async throws -> [GitHubRepository]{

        let url = URL(
            string: "https://api.github.com/users/\(username)/repos?page=\(page)&per_page=\(perPage)"
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
