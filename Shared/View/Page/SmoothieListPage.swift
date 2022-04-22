import SwiftUI

struct SmoothieListPage: View {
  private struct UIState {
    var selectedSmoothie: Smoothie.ID?
    var filterKeyword: String = ""
  }

  @State private var uiState = UIState()
  @StateObject private var smoothieState: SmoothieState = .init(dataSource: .live)
  @ObservedObject private var favoriteSmoothieState: FavoriteSmoothieState

  init(favoriteSmoothieState: FavoriteSmoothieState) {
    self.favoriteSmoothieState = favoriteSmoothieState
  }

  var body: some View {
    List {
      ForEach(
        SmoothieListPageLogic.filter(
          with: uiState.filterKeyword,
          target: smoothieState.smoothies
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
            favoriteSmoothieState.update(smoothie)
          } label: {
            favoriteSmoothieState.favoriteSmoothies.contains(smoothie)
            ? Image(systemName: "heart.slash")
            : Image(systemName: "heart")
          }
          .tint(.pink)
        }
      }
    }
    .searchable(text: $uiState.filterKeyword)
    .navigationTitle("Menu")
    .task {
      await smoothieState.fetchSmoothies()
    }
  }
}

enum SmoothieListPageLogic {
  static func toString(from date: Date) -> String {
    let formatter: DateFormatter = .slash
    return formatter.string(from: date)
  }

  static func filter(with keyword: String, target: [Smoothie]) -> [Smoothie] {
    guard !keyword.isEmpty else { return target }
    return target.filter { $0.title.contains(keyword) }
  }
}

struct SmoothieListPage_Previews: PreviewProvider {
  static var previews: some View {
    SmoothieListPage(favoriteSmoothieState: .init())
  }
}
