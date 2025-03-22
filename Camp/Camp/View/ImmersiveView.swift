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
        RealityView { content, attachments  in
            let entity = Entity()
            viewModel.rootEntity = entity
            viewModel.attachments = attachments
            content.add(entity)
            
            await viewModel.setup(appModel: appModel, environment: .spring)
        } attachments: {
            Attachment(id: "Menu") {
                VStack(spacing: 40) {
                    Button {
                        openWindow(id: appModel.environmentSelectionWindowID)
                    } label: {
                        Text("Changed Environment")
                            .font(.largeTitle)
                            .padding(40)
                    }
                    .disabled(appModel.isWindowOpen(type: .environmentSelection))
                    
                    Button {
                        Task {
                            appModel.soundStorage.stopAllAudio()
                            await dismissImmersiveSpace()
                            openWindow(id: appModel.titleWindowID)
                        }
                    } label: {
                        Text("Exit")
                            .font(.largeTitle)
                            .padding(40)
                    }
                }
            }
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
