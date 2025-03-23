import SwiftUI

struct CampEnvironmentSelectionView: View {
    @Environment(AppModel.self) var appModel
    @Environment(\.dismissWindow) var dismissWindow
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Environments")
                .font(.largeTitle)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 40) {
                    ForEach(CampEnvironment.allCases, id: \.id) { environment in
                        CampEnvironmentItemView(environment, isSelected: appModel.campEnvironment == environment) {
                            appModel.campEnvironment = environment
                            UserDefaultsWrapper.saveCampEnvironment(environment)
                            
                            dismissWindow(id: appModel.environmentSelectionWindowID)
                        }
                    }
                }
                .padding(.horizontal, 40)
            }
        }
        .frame(width: 600, height: 500)
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
