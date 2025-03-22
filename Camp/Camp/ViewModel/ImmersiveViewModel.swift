import SwiftUI
import RealityKit
import RealityKitContent

@Observable
@MainActor
final class ImmersiveViewModel {
    var rootEntity: Entity?
    
    func setup(appModel: AppModel, environment: CampEnvironment, crafts: [Craft]) async {
        rootEntity?.children.removeAll()
        
        // TODO: Switch scene name from environment
        guard let scene = try? await Entity(named: "Spring", in: realityKitContentBundle) else { return }
        scene.scale *= 10
        rootEntity?.addChild(scene)
        
        for craft in crafts {
            if let entity = scene.findEntity(named: craft.name) {
                var position = craft.translation.simd3
                
                entity.setPosition(position, relativeTo: nil)
//                    entity.setScale(craft.scale.simd3, relativeTo: nil)
                entity.setOrientation(.init(vector: craft.orientation.simd4), relativeTo: nil)
            }
        }

        if let skybox = Entity.createSkybox(environment: environment) {
            rootEntity?.addChild(skybox)
        }

        let light = Entity.createDirectionalLight()
        rootEntity?.addChild(light)

        try? await appModel.soundStorage.load()
        let soundEntity = appModel.soundStorage.soundEntity
        rootEntity?.addChild(soundEntity)
        await appModel.soundStorage.play(sound: .animalCrossing)
    }
}
