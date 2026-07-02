//
//  DashboardViewModelTests.swift
//  DevHubAIApp
//
//  Created by ESI on 6/25/26.
//

import Testing
@testable import DevHubAIApp

struct DashboardViewModelTests {

    @Test
    func searchLoadsUserAndRepositories() async throws {

        let repository = GitHubRepository(
            id: 1,
            name: "swift",
            description: "Swift Language",
            stargazersCount: 100,
            forksCount: 20,
            language: "Swift",
            htmlUrl: "https://github.com/apple/swift"
        )

        let service = MockGitHubService(

            user: GitHubUser(
                login: "apple",
                name: "Apple",
                avatarUrl: "",
                followers: 100,
                following: 10,
                publicRepos: 1
            ),

            repositories: [repository]
        )

        let viewModel = await DashboardViewModel(
            service: service
        )

        await MainActor.run {
            viewModel.username = "apple"
        }
        await viewModel.search()
        await MainActor.run {
            #expect(viewModel.user?.login == "apple")
            #expect(viewModel.user?.name == "Apple")
            #expect(viewModel.repositories.count == 1)
            #expect(viewModel.repositories.first?.name == "swift")
        }
    }
    
    @Test
    func searchHandlesError() async {

        let service = MockGitHubService(

            user: GitHubUser(
                login: "",
                name: nil,
                avatarUrl: "",
                followers: 0,
                following: 0,
                publicRepos: 0
            ),

            repositories: []
        )

        service.shouldThrowError = true

        let viewModel = await DashboardViewModel(
            service: service
        )

        await MainActor.run {
            viewModel.username = "apple"
        }

        await viewModel.search()

        await MainActor.run {

            #expect(viewModel.user == nil)

            #expect(viewModel.repositories.isEmpty)

            #expect(
                viewModel.errorMessage == "User not found"
            )
        }
    }
    
    @Test
    func repositoriesAreSortedByStars() async {

        let repositories = [

            GitHubRepository(
                id: 1,
                name: "A",
                description: nil,
                stargazersCount: 100,
                forksCount: 5,
                language: "Swift",
                htmlUrl: ""
            ),

            GitHubRepository(
                id: 2,
                name: "B",
                description: nil,
                stargazersCount: 500,
                forksCount: 2,
                language: "Swift",
                htmlUrl: ""
            ),

            GitHubRepository(
                id: 3,
                name: "C",
                description: nil,
                stargazersCount: 200,
                forksCount: 1,
                language: "Swift",
                htmlUrl: ""
            )
        ]

        let service = MockGitHubService(

            user: GitHubUser(
                login: "apple",
                name: "Apple",
                avatarUrl: "",
                followers: 0,
                following: 0,
                publicRepos: 3
            ),

            repositories: repositories
        )

        let viewModel = await DashboardViewModel(
            service: service
        )

        await MainActor.run {
            viewModel.username = "apple"
        }

        await viewModel.search()

        await MainActor.run {

            viewModel.selectedSort = .stars

            #expect(
                viewModel.filteredRepositories.first?.name == "B"
            )

            #expect(
                viewModel.filteredRepositories.last?.name == "A"
            )
        }
    }
}

