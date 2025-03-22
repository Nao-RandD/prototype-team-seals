import SwiftUI
import RealityKit

struct CampEnvironmentItemView: View {
    var onSelect: () -> Void
    
    private var environment: CampEnvironment
    
    init(_ environment: CampEnvironment, onSelect: @escaping () -> Void) {
        self.environment = environment
        self.onSelect = onSelect
    }
    
    var body: some View {        
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(environment.color)
            
            VStack(spacing: 0) {
                Text(environment.rawValue)
                    .font(.system(size: 24, weight: .bold))
                
                Image(environment.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
            }
            .padding(.top, 24)
            .padding(.bottom, 16)
        }
        .frame(width: 200, height: 200)
        .onTapGesture {
            onSelect()
        }
        .hoverEffect()

    }
}

#Preview {
    CampEnvironmentItemView(.spring) {}
}
