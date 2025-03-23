import SwiftUI

struct ImmersiveMenuView: View {
    @Environment(AppModel.self) var appModel
    
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
        
    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                Rectangle()
                    .foregroundColor(appModel.campEnvironment.color)
                
                VStack(spacing: 16) {
                    Text(appModel.campEnvironment.rawValue)
                        .font(.system(size: 24, weight: .bold))
                    
                    Image(appModel.campEnvironment.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                    
                    Spacer()
                }
                .padding(.top, 24)
                .padding(.bottom, 16)
                
                VStack {
                    Spacer()

                    ZStack {
                        Rectangle()
                            .foregroundColor(.black)
                            .opacity(0.5)
                            .frame(height: 80)
                        
                        Button {
                            openWindow(id: appModel.environmentSelectionWindowID)
                        } label: {
                            Text("Change")
                        }
                    }
                }
            }
            .frame(width: 200, height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
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
                Text("Exit")
            }
        }
        .frame(width: 200, height: 400)
    }
}
