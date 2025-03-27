import SwiftUI
import RealityKit
import RealityKitContent
import SwiftData

struct ImmersiveView: View {
    @Environment(AppModel.self) var appModel
    @Environment(\.modelContext) var modelContext
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    @Query private var crafts: [Craft]
    
    @State var viewModel: ImmersiveViewModel = .init()
    @State var skybox: Entity = .init()

    var body: some View {
        RealityView { content  in
            let entity = Entity()
            viewModel.rootEntity = entity
            content.add(entity)
            
            await viewModel.setup(appModel: appModel, environment: appModel.campEnvironment, crafts: crafts)
        }
        .onChange(of: appModel.campEnvironment, { _, environment in
            Task {
                await viewModel.setup(appModel: appModel, environment: environment, crafts: crafts)
            }
        })
        .onAppear {
            appModel.changeImmersiveSpaceState(.open)
        }
        .onDisappear {
            appModel.changeImmersiveSpaceState(.closed)
        }
        .craftGesture { name, translation, scale, orientation in
            saveCraft(.init(name: name,
                            environment: appModel.campEnvironment.rawValue,
                            translation: translation,
                            scale: scale,
                            orientation: orientation))
        }
    }
    
    private func saveCraft(_ craft: Craft) {
        modelContext.insert(craft)
        
        if modelContext.hasChanges {
            try? modelContext.save()
        } else {
            print("modelContext has no changes")
        }
    }
}

#Preview(immersionStyle: .full) {
    ImmersiveView()
        .environment(AppModel())
}
