import SwiftUI
import RealityKit

struct CampEnvironmentItemView: View {
    @Environment(AppModel.self) var appModel
    
    var isSelected: Bool
    var onSelect: () -> Void
    
    private var environment: CampEnvironment
    
    init(_ environment: CampEnvironment, isSelected: Bool, onSelect: @escaping () -> Void) {
        self.environment = environment
        self.isSelected = isSelected
        self.onSelect = onSelect
    }
    
    var body: some View {        
        ZStack {
            Rectangle()
                .foregroundColor(environment.color)
            
            VStack(spacing: 16) {
                Text(environment.localizedString)
                    .font(.system(size: 24, weight: .bold))
                
                Image(environment.imageName)
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
                        onSelect()
                    } label: {
                        Text("Select")
                    }
                }
            }
            
            if isSelected {
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.5)
                    .overlay {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }
            }
            
            if !environment.isAvailable {
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.5)
                    .overlay {
                        Text("Coming soon...")
                            .font(.title)
                    }
            }
        }
        .frame(width: 200, height: 300)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .disabled(isSelected || !environment.isAvailable)
    }
}

#Preview {
    HStack {
        CampEnvironmentItemView(.spring, isSelected: false) {}
        CampEnvironmentItemView(.spring, isSelected: true) {}
    }
}
