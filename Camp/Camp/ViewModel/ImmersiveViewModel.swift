import SwiftUI
import RealityKit
import RealityKitContent

@Observable
@MainActor
final class ImmersiveViewModel {
    let sceneScale: Float = 10
    
    var rootEntity: Entity?
    
    func setup(appModel: AppModel, environment: CampEnvironment, crafts: [Craft]) async {
        rootEntity?.children.removeAll()
        
        guard let scene = try? await Entity(named: environment.rawValue, in: realityKitContentBundle) else { return }
        scene.scale *= sceneScale
        rootEntity?.addChild(scene)
        
        for craft in crafts {
            if let entity = scene.findEntity(named: craft.name) {
                var position = craft.translation.simd3
                position *= sceneScale
                
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
    }
}
