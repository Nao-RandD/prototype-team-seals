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
}
