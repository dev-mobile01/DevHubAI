//
//  GitHubUserTests.swift
//  DevHubAIApp
//
//  Created by ESI on 6/25/26.
//

import Testing
@testable import DevHubAIApp

struct GitHubUserTests {

    @Test
    func userInitialization() {
        
        let user = GitHubUser(
            login: "apple",
            name: "Apple",
            avatarUrl: "https://github.com/apple.png",
            followers: 100,
            following: 0,
            publicRepos: 500
        )

        #expect(user.login == "apple")
        #expect(user.name == "Apple")
        #expect(user.publicRepos == 500)
    }
}
