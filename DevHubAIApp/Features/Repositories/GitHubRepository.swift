//
//  GitHubRepository.swift
//  DevHubAIApp
//
//  Created by ESI on 6/17/26.
//

import Foundation

struct GitHubRepository: Codable, Identifiable {

    let id: Int

    let name: String

    let description: String?

    let stargazersCount: Int

    let forksCount: Int

    let language: String?

    enum CodingKeys: String, CodingKey {

        case id

        case name

        case description

        case language

        case stargazersCount = "stargazers_count"

        case forksCount = "forks_count"
    }
}
