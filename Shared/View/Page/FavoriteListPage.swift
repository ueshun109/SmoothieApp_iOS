import SwiftUI

struct FavoriteListPage: View {
  private struct UIState {
    var selectedSmoothie: Smoothie.ID?
    var filterKeyword: String = ""
  }

  @State private var uiState = UIState()
  @ObservedObject private var favoriteSmoothieState: FavoriteSmoothieState

  init(favoriteSmoothieState: FavoriteSmoothieState) {
    self.favoriteSmoothieState = favoriteSmoothieState
  }

  var body: some View {
    ZStack {
      if favoriteSmoothieState.favoriteSmoothies.isEmpty {
        VStack {
          Spacer()
          Text("お気に入りのスムージを追加しよう！！")
            .font(.subheadline)
            .foregroundColor(.secondary)
          Spacer()
        }
      } else {
        List {
          ForEach(
            FavoriteListPageLogic.filter(
              with: uiState.filterKeyword,
              target: Array(favoriteSmoothieState.favoriteSmoothies)
            )
          ) { smoothie in
            NavigationLink(
              tag: smoothie.id,
              selection: $uiState.selectedSmoothie
            ) {
              Text(smoothie.title)
            } label: {
              SmoothieRow(smoothie: smoothie)
            }
            .swipeActions(edge: .trailing) {
              Button {
                withAnimation {
                  favoriteSmoothieState.update(smoothie)
                }
              } label: {
                favoriteSmoothieState.favoriteSmoothies.contains(smoothie)
                ? Image(systemName: "heart.slash")
                : Image(systemName: "heart")
              }
              .tint(.pink)
            }
          }
        }
      }
    }
    .searchable(text: $uiState.filterKeyword)
    .navigationTitle("Favorites")
  }
}

enum FavoriteListPageLogic {
  static func filter(with keyword: String, target: [Smoothie]) -> [Smoothie] {
    guard !keyword.isEmpty else { return target }
    return target.filter { $0.title.contains(keyword) }
  }
}

struct FavoriteListPage_Previews: PreviewProvider {
  static var previews: some View {
    FavoriteListPage(favoriteSmoothieState: .init())
  }
}
