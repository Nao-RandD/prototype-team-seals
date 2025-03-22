import SwiftUI

struct ImmersiveMenuView: View {
    @Environment(AppModel.self) var appModel
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
        
    var body: some View {
        VStack {
            CampEnvironmentItemView(appModel.campEnvironment, isSelected: false) {
                openWindow(id: appModel.environmentSelectionWindowID)
            }
            
            Button {
                Task {
                    appModel.soundStorage.stopAllAudio()
                    
                    dismissWindow(id: appModel.immersiveMenuWindowID)
                    dismissWindow(id: appModel.environmentSelectionWindowID)
                    openWindow(id: appModel.titleWindowID)
                    
                    if !appModel.isImmersiveSpaceClosed {
                        await dismissImmersiveSpace()
                    }
                }
            } label: {
                Image(systemName: "arrow.up.right.and.arrow.down.left")
                    .font(.title)
            }
        }
        .frame(width: 200, height: 300)
    }
}
