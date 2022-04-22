import SwiftUI

extension Smoothie {
  var image: Image {
    Image("smoothie/\(id)", label: Text(title))
      .renderingMode(.original)
  }
}

extension View {
  func clipShapeForImage() -> some View {
    self.modifier(ClipShapeForImage())
  }
}

struct ClipShapeForImage: ViewModifier {
  private let imageClipShape = RoundedRectangle(cornerRadius: 10, style: .continuous)

  func body(content: Content) -> some View {
    content
      .clipShape(imageClipShape)
      .overlay(imageClipShape.strokeBorder(.quaternary, lineWidth: 0.5))
  }
}

extension DateFormatter {
  enum Template: String {
    case dateSlash = "yMd" // 2021/12/1
  }

  func setTemplate(_ template: Template) {
    dateFormat = DateFormatter.dateFormat(fromTemplate: template.rawValue, options: 0, locale: Locale(identifier: "ja_JP"))
  }
}

extension DateFormatter {
  /// e.g. 2022/12/1
  static let slash: DateFormatter = {
    let formatter = DateFormatter()
    formatter.setTemplate(.dateSlash)
    return formatter
  }()
}
