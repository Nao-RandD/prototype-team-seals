import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @Environment(AppModel.self) var appModel
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    var body: some View {
        RealityView { content, attachments  in
            // Add the initial RealityKit content
            if let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                immersiveContentEntity.scale *= 10
                content.add(immersiveContentEntity)

                // Put skybox here.  See example in World project available at
                // https://developer.apple.com/
                
                let lightEntity = Entity()
                let redLightComponent = DirectionalLightComponent(
                    color: .white, intensity: 2000
                )
                let lightShadowComponent = DirectionalLightComponent.Shadow()
                lightEntity.components.set([redLightComponent, lightShadowComponent])
                lightEntity.orientation = simd_quatf(angle: -.pi/2, axis: .init(1, 0, 0))
                content.add(lightEntity)
                
                if let menu = attachments.entity(for: "Menu") {
                    menu.position = [0, 0.5, -0.2]
                    content.add(menu)
                }
            }
        } attachments: {
            Attachment(id: "Menu") {
                VStack {
                    Button {
                        openWindow(id: appModel.environmentSelectionWindowID)
                    } label: {
                        Text("Changed Environment")
                            .font(.largeTitle)
                            .padding(40)
                    }
                    
                    Button {
                        Task {
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
