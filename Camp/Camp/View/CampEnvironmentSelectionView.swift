import SwiftUI

struct CampEnvironmentSelectionView: View {
    @Environment(AppModel.self) var appModel
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Environments")
                .font(.extraLargeTitle)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 40) {
                    ForEach(CampEnvironment.allCases, id: \.id) { environment in
                        CampEnvironmentItemView(environment, isSelected: appModel.campEnvironment == environment) {
                            appModel.campEnvironment = environment
                            UserDefaultsWrapper.saveCampEnvironment(environment)
                        }
                    }
                }
                .padding(.horizontal, 40)
            }
            .navigationTitle("Environments")
        }
        .frame(width: 600, height: 400)
        .onAppear {
            appModel.changeWindowState(.open, type: .environmentSelection)
        }
        .onDisappear {
            appModel.changeWindowState(.closed, type: .environmentSelection)
        }
    }
}

#Preview {
    CampEnvironmentSelectionView()
        .environment(AppModel())
}
