import SwiftUI

@MainActor
final class FavoriteSmoothieState: ObservableObject {
  @Published var favoriteSmoothies: Set<Smoothie> = []

  func update(_ smoothie: Smoothie) {
    if favoriteSmoothies.contains(smoothie) {
      favoriteSmoothies.remove(smoothie)
    } else {
      favoriteSmoothies.insert(smoothie)
    }
  }
}
