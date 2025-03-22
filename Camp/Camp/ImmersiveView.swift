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

                if let skybox = Entity.createSkybox(name: "Skybox") {
                    content.add(skybox)
                }
                
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

                try? await appModel.soundStorage.load()
                let soundEntity = appModel.soundStorage.soundEntity
                content.add(soundEntity)
                await appModel.soundStorage.play(sound: .animalCrossing)
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
