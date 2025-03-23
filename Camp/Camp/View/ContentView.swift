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
        VStack(spacing: 16) {
            Text("どこキャン")
                .font(.system(size: 80, weight: .bold))
            Text("- Doko Camp -")
                .font(.extraLargeTitle2)
                .padding(.init(top: 0, leading: 0, bottom: 32, trailing: 0))

            Text("""
                Camp Anywhere, Anytime, with Anyone!
            """)
                .font(.title)
                .padding()
                .background(.ultraThickMaterial)
                .cornerRadius(20)
            Button(action: {
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
                    openWindow(id: appModel.immersiveMenuWindowID)
                }
            }) {
                Text("Enter")
                    .font(.title)
                    .padding()
            }
            .disabled(appModel.isImmersiveSpaceInTransition)

            Model3D(named: "Placeholder", bundle: realityKitContentBundle) { model in
                model
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 300)
                    .rotation3DEffect(.init(radians: .pi), axis: (x: 0, y: 1, z: 0))
            } placeholder: {
                ProgressView()
            }

        }
        .padding()
        .onAppear {
            appModel.changeWindowState(.open, type: .title)
        }
        .onDisappear {
            appModel.changeWindowState(.closed, type: .title)
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
