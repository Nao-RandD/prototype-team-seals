import SwiftUI
import RealityKit
import RealityKitContent

@Observable
@MainActor
final class ImmersiveViewModel {
    var rootEntity: Entity?
    var attachments: RealityViewAttachments?
    
    func setup(appModel: AppModel, environment: CampEnvironment) async {
        rootEntity?.children.removeAll()
        
        // TODO: Switch scene name from environment
        guard let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) else { return }
        scene.scale *= 10
        rootEntity?.addChild(scene)

        if let skybox = Entity.createSkybox(environment: environment) {
            rootEntity?.addChild(skybox)
        }

        let light = Entity.createDirectionalLight()
        rootEntity?.addChild(light)

        if let menu = attachments?.entity(for: "Menu") {
            menu.position = [0, 0.5, -0.5]
            rootEntity?.addChild(menu)
        }

        try? await appModel.soundStorage.load()
        let soundEntity = appModel.soundStorage.soundEntity
        rootEntity?.addChild(soundEntity)
        await appModel.soundStorage.play(sound: .animalCrossing)
    }
}
