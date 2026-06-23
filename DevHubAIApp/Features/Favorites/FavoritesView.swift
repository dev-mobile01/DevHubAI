//
//  FavoritesView.swift
//  DevHubAIApp
//
//  Created by ESI on 6/22/26.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {

    @Query
    private var favorites:
        [FavoriteRepository]

    @Environment(\.modelContext)
    private var modelContext

    private func deleteFavorite(
        offsets: IndexSet
    ) {

        for index in offsets {

            modelContext.delete(
                favorites[index]
            )
        }
    }
    
    var body: some View {

        NavigationStack {
            
            Group {
                if favorites.isEmpty {
                    
                    ContentUnavailableView {
                        
                        Label(
                            "No Favorites",
                            systemImage: "star"
                        )
                        
                    } description: {
                        
                        Text(
                            "Save repositories to access them later."
                        )
                    }
                    
                } else {
                    
                    List {
                        ForEach(favorites) { repository in
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
                        .onDelete(perform: deleteFavorite)
                    }
                    .navigationTitle(
                        "Favorites"
                    )
                }
            }
            .navigationTitle("Favorites")
        }
    }
}


