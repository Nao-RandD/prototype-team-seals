import SwiftUI

enum CampEnvironment: String, CaseIterable {
    case spring = "Spring"
    case summer = "Summer"
    case autumn = "Autumn"
    case winter = "Winter"
    case space = "Space"
}

struct CampEnvironmentSelectionView: View {
    var body: some View {
        NavigationStack {
            HStack(spacing: 40) {
                CampEnvironmentItemView(.spring)
                CampEnvironmentItemView(.summer)
                CampEnvironmentItemView(.autumn)
                CampEnvironmentItemView(.winter)
                CampEnvironmentItemView(.space)
            }
            .navigationTitle("Environments")
        }
    }
}

#Preview {
    CampEnvironmentSelectionView()
}
