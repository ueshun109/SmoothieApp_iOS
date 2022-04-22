import SwiftUI

struct SmoothieRow: View {
  let smoothie: Smoothie

  var body: some View {
    HStack(alignment: .top) {
      smoothie.image
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 60, height: 60)
        .clipShapeForImage()

      VStack(alignment: .leading) {
        Text(smoothie.title)
          .font(.headline)

        Spacer()

        HStack {
          Text("¥\(smoothie.price)")
            .font(.callout)
            .foregroundStyle(.secondary)

          Spacer()

          Text("~ \(SmoothieListPageLogic.toString(from: smoothie.endDate))")
            .font(.callout)
            .foregroundStyle(.secondary)
        }
        .padding(.trailing, 16)
      }
      .padding(.vertical, 8)
    }
  }
}
