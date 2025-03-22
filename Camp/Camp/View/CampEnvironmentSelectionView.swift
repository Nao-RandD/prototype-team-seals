import SwiftUI

enum CampEnvironment: String, CaseIterable {
    var id: String { rawValue }
    
    case spring = "Spring"
    case summer = "Summer"
    case autumn = "Autumn"
    case winter = "Winter"
    case space = "Space"

    var skyboxName: String {
        "Skybox_" + self.rawValue
    }
}

struct CampEnvironmentSelectionView: View {
    @Environment(AppModel.self) var appModel
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 40) {
                    ForEach(CampEnvironment.allCases, id: \.id) { environment in
                        CampEnvironmentItemView(environment) {
                            appModel.campEnvironment = environment
                        }
                        .frame(width: 300, height: 400)
                    }
                }
                .padding(.horizontal, 40)
            }
            .navigationTitle("Environments")
        }
    }
}

#Preview {
    CampEnvironmentSelectionView()
}
