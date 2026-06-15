//
//  GitHubUser.swift
//  DevHubAIApp
//
//  Created by ESI on 6/15/26.
//

import Foundation

struct GitHubUser: Codable {

    let login: String

    let name: String?

    let avatarUrl: String

    let followers: Int

    let following: Int

    let publicRepos: Int

    enum CodingKeys: String, CodingKey {

        case login
        case name

        case avatarUrl = "avatar_url"

        case followers

        case following

        case publicRepos = "public_repos"
    }
}
