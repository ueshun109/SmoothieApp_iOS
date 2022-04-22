enum SmoothieDataSource {
  case live

  func smoothies() async throws -> [Smoothie] {
    switch self {
    case .live:
      return Smoothie.all
    }
  }
}
