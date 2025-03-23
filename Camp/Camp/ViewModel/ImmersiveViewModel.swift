import SwiftUI
import RealityKit
import RealityKitContent

@Observable
@MainActor
final class ImmersiveViewModel {
    var rootEntity: Entity?
    
    func setup(appModel: AppModel, environment: CampEnvironment) async {
        rootEntity?.children.removeAll()
        
        guard let scene = try? await Entity(named: environment.rawValue, in: realityKitContentBundle) else { return }
        scene.scale *= 10
        rootEntity?.addChild(scene)

        if let skybox = Entity.createSkybox(environment: environment) {
            rootEntity?.addChild(skybox)
        }

        let light = Entity.createDirectionalLight()
        rootEntity?.addChild(light)
    }
}
