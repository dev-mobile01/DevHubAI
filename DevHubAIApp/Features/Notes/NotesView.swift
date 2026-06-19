//
//  NotesView.swift
//  DevHubAIApp
//
//  Created by ESI on 6/15/26.
//

import SwiftUI
import SwiftData

struct NotesView: View {

    @Query
    private var favorites:
        [FavoriteRepository]

    var body: some View {

        NavigationStack {

            List(favorites) { repository in

                VStack(
                    alignment: .leading
                ) {

                    Text(
                        repository.name
                    )
                    .bold()

                    Text(
                        repository.language
                    )
                    .foregroundStyle(
                        .secondary
                    )
                }
            }
            .navigationTitle(
                "Favorites"
            )
        }
    }
}
