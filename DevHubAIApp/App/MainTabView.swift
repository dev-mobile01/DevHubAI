//
//  MainTabView.swift
//  DevHubAIApp
//
//  Created by ESI on 6/15/26.
//

import SwiftUI

struct MainTabView: View {

    var body: some View {

        TabView {

            DashboardView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            DeveloperToolsView()
                .tabItem {
                    Label("Tools", systemImage: "hammer")
                }

            NotesView()
                .tabItem {
                    Label("Notes", systemImage: "note.text")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
