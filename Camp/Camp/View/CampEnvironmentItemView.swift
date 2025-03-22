import SwiftUI
import RealityKit

struct CampEnvironmentItemView: View {
    @State private var viewModel = CampEnvironmentItemViewModel()
    
    private var environment: CampEnvironment
    
    init(_ environment: CampEnvironment) {
        self.environment = environment
    }
    
    var body: some View {
//        ZStack(alignment: .bottom) {
//            RoundedRectangle(cornerRadius: 16)
//                .foregroundStyle(.black)
//                .frame(width: 200, height: 200)
//            
//            Button {
//                
//            } label: {
//                Text(environment.rawValue)
//                    .padding(.vertical, 16)
//            }
//            .padding(16)
//        }
        ZStack {
            GeometryReader3D { geometry in
                RealityView { content in
                    let entity = Entity()
                    viewModel.rootEntity = entity
                    content.add(entity)
                    
                    viewModel.setupPortal(name: "skybox")
                } update: { content in
                    let size = content.convert(geometry.size, from: .local, to: .scene)
                    viewModel.updatePortalSize(width: size.x, height: size.y)
                }
                .frame(depth: 0.4)
            }
            .frame(depth: 0.4)
        }
    }
}

@Observable
@MainActor
final class CampEnvironmentItemViewModel {
    var rootEntity: Entity?
    var worldEntiry: Entity?
    var skyboxEntity: Entity?
    
    private let portalPlane = ModelEntity(
        mesh: .generatePlane(width: 1.0, height: 1.0),
        materials: [PortalMaterial()]
    )
    
    func setupPortal(name: String) {
        let world = Entity()
        worldEntiry = world
        
        world.position.z -= 1
        world.components.set(WorldComponent())
        
//        if let skybox = Entity.createSkybox(name: name) {
//            skyboxEntity = skybox
//            world.addChild(skybox)
//        }
        let sphere = ModelEntity(mesh: .generateSphere(radius: 0.2), materials: [SimpleMaterial(color: .red, isMetallic: false)])
        world.addChild(sphere)
        
        rootEntity?.addChild(world)
        
        portalPlane.components.set(PortalComponent(target: world))
        rootEntity?.addChild(portalPlane)
    }
    
    func updatePortalSize(width: Float, height: Float) {
        portalPlane.model?.mesh = .generatePlane(width: width, height: height, cornerRadius: 0.03)
    }
    
    private func createSkybox(_ name: String) -> Entity? {
        guard let entity = Entity.createSkybox(name: name) else { return nil }
        return entity
    }
}

#Preview {
    CampEnvironmentItemView(.spring)
}
