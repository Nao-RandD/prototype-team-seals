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
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.black)
                .frame(width: 200, height: 200)
            
            Button {
                onSelect()
            } label: {
                Text(environment.rawValue)
                    .padding(.vertical, 16)
            }
            .padding(16)
        }
    }
}

#Preview {
    CampEnvironmentItemView(.spring) {}
}
