//
//  FavoriteRepository.swift
//  DevHubAIApp
//
//  Created by ESI on 6/18/26.
//

import Foundation
import SwiftData

@Model
final class FavoriteRepository {

    var id: Int

    var name: String

    var repositoryDescription: String

    var language: String

    init(
        id: Int,
        name: String,
        repositoryDescription: String,
        language: String
    ) {

        self.id = id

        self.name = name

        self.repositoryDescription = repositoryDescription

        self.language = language
    }
}
