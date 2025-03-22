import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @Environment(AppModel.self) var appModel
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    @State var viewModel: ImmersiveViewModel = .init()
    @State var skybox: Entity = .init()

    var body: some View {
        RealityView { content  in
            let entity = Entity()
            viewModel.rootEntity = entity
            content.add(entity)
            
            await viewModel.setup(appModel: appModel, environment: appModel.campEnvironment)
        }
        .onChange(of: appModel.campEnvironment, { _, environment in
            Task {
                await viewModel.setup(appModel: appModel, environment: environment)
            }
        })
        .onAppear {
            appModel.changeImmersiveSpaceState(.open)
        }
        .onDisappear {
            appModel.changeImmersiveSpaceState(.closed)
        }
        .craftGesture { craft in
            // TODO: Save craft info
        }
    }
}

#Preview(immersionStyle: .full) {
    ImmersiveView()
        .environment(AppModel())
}
