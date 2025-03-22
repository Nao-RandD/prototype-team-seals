import SwiftUI

@main
struct CampApp: App {

    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup(id: appModel.titleWindowID) {
            ContentView()
                .environment(appModel)
        }
        
        WindowGroup(id: appModel.immersiveMenuWindowID) {
            ImmersiveMenuView()
                .environment(appModel)
        }
        .windowStyle(.plain)
        .windowResizability(.contentSize)
        
        WindowGroup(id: appModel.environmentSelectionWindowID) {
            CampEnvironmentSelectionView()
                .environment(appModel)
        }
        .windowResizability(.contentSize)

        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.full ), in: .full)
    }
}
