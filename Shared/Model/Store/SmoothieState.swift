import SwiftUI

@MainActor
final class SmoothieState: ObservableObject {
  @Published private(set) var smoothies: [Smoothie] = []
  let dataSource: SmoothieDataSource

  init(dataSource: SmoothieDataSource) {
    self.dataSource = dataSource
  }

  func fetchSmoothies() async {
    do {
      smoothies = try await dataSource.smoothies()
    } catch {
      // TODO: Handle error
    }
  }
}
