import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @Environment(AppModel.self) var appModel
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Spacial Camp ")
                .font(.extraLargeTitle)
            
            Model3D(named: "Placeholder", bundle: realityKitContentBundle) { model in
                model
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                    .rotation3DEffect(.init(radians: .pi), axis: (x: 0, y: 1, z: 0))
            } placeholder: {
                ProgressView()
            }
            
            Button("Enter") {
                Task { @MainActor in
                    guard appModel.isImmersiveSpaceClosed else { return }
                    appModel.changeImmersiveSpaceState(.inTransition)
                    
                    switch await openImmersiveSpace(id: appModel.immersiveSpaceID) {
                    case .opened:
                        break
                    case .userCancelled, .error:
                        fallthrough
                    @unknown default:
                        appModel.changeImmersiveSpaceState(.closed)
                    }
                    
                    // Close title window after opened immersive space
                    dismissWindow(id: appModel.titleWindowID)
                }
            }
            .disabled(appModel.isImmersiveSpaceInTransition)
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
