import SwiftUI
import RealityKit

struct CampEnvironmentItemView: View {
    @Environment(AppModel.self) var appModel
    
    var isSelected: Bool
    var onTap: () -> Void
    
    private var environment: CampEnvironment
    
    init(_ environment: CampEnvironment, isSelected: Bool, onTap: @escaping () -> Void) {
        self.environment = environment
        self.isSelected = isSelected
        self.onTap = onTap
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
            
            if isSelected {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.black)
                    .opacity(0.5)
                    .overlay {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }
            }
        }
        .frame(width: 200, height: 200)
        .onTapGesture {
            onTap()
        }
        .hoverEffect()
        .disabled(isSelected)
    }
}

#Preview {
    HStack {
        CampEnvironmentItemView(.spring, isSelected: false) {}
        CampEnvironmentItemView(.spring, isSelected: true) {}
    }
}
