//
//  SmoothieAppApp.swift
//  Shared
//
//  Created by shun uematsu on 2022/04/22.
//

import SwiftUI

@main
struct SmoothieApp: App {
  var body: some Scene {
    WindowGroup {
      RootView()
    }
  }
}

struct RootView: View {
  enum Tab {
    case menu
    case favorites
  }
  private struct UIState {
    var selection: Tab = .menu
  }

  @State private var uiState = UIState()
  @StateObject private var favoriteSmoothieState = FavoriteSmoothieState()

  var body: some View {
    TabView(selection: $uiState.selection) {
      NavigationView {
        SmoothieListPage(favoriteSmoothieState: favoriteSmoothieState)
      }
      .tabItem {
        Label {
          Text("Menu")
        } icon: {
          Image(systemName: "list.bullet")
        }
      }
      .tag(Tab.menu)

      NavigationView {
        FavoriteListPage(favoriteSmoothieState: favoriteSmoothieState)
      }
      .tabItem {
        Label {
          Text("Favorite")
        } icon: {
          Image(systemName: "heart")
        }
      }
      .tag(Tab.favorites)
    }
  }
}
