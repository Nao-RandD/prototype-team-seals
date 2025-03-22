import RealityKit

extension Entity {
    static func createSkybox(environment: CampEnvironment) -> Entity? {
        let sphere = MeshResource.generateSphere(radius: 1000)
        var material = UnlitMaterial()
        
        do {
            let texture = try TextureResource.load(named: environment.skyboxName)
            material.color = .init(texture: .init(texture))
            
            let entity = Entity()
            entity.components.set(ModelComponent(mesh: sphere, materials: [material]))
            entity.scale = .init(x: -1, y: 1, z: 1)
            return entity
        } catch {
            return nil
        }
    }
    
    static func createSkybox(name: String) -> Entity? {
        let sphere = MeshResource.generateSphere(radius: 1000)
        var material = UnlitMaterial()
        
        do {
            let texture = try TextureResource.load(named: name)
            material.color = .init(texture: .init(texture))
            
            let entity = Entity()
            entity.components.set(ModelComponent(mesh: sphere, materials: [material]))
            entity.scale = .init(x: -1, y: 1, z: 1)
            return entity
        } catch {
            return nil
        }
    }
    
    static func createDirectionalLight() -> Entity {
        let lightEntity = Entity()
        let redLightComponent = DirectionalLightComponent(
            color: .white, intensity: 2000
        )
        
        let lightShadowComponent = DirectionalLightComponent.Shadow()
        lightEntity.components.set([redLightComponent, lightShadowComponent])
        lightEntity.orientation = simd_quatf(angle: -.pi/2, axis: .init(1, 0, 0))
        
        return lightEntity
    }
}
