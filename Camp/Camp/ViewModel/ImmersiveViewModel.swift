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
        
        guard let scene = try? await Entity(named: environment.environmentName, in: realityKitContentBundle) else { return }
        scene.scale *= sceneScale
        rootEntity?.addChild(scene)
        
        // Restore craft positions and rotations
        restoreCrafts(crafts, scene: scene, environment: environment)

        if let skybox = Entity.createSkybox(environment: environment) {
            rootEntity?.addChild(skybox)
        }

        // Setup particles
        setupParticles(environment: environment)

        let light = Entity.createDirectionalLight()
        rootEntity?.addChild(light)
    }
    
    private func restoreCrafts(_ crafts: [Craft], scene: Entity, environment: CampEnvironment) {
        for craft in crafts {
            if let entity = scene.findEntity(named: craft.name), craft.environment == environment.rawValue {
                var position = craft.translation.simd3
                position *= sceneScale
                
                entity.setPosition(position, relativeTo: nil)
                entity.setOrientation(.init(vector: craft.orientation.simd4), relativeTo: nil)
            }
        }
    }
    
    private func setupParticles(environment: CampEnvironment) {
        Task {
            if let particle = try? await Entity(named: environment.particleName, in: realityKitContentBundle) {
                particle.position = [0, 1, 0]
                rootEntity?.addChild(particle)
            }
        }
    }
}
