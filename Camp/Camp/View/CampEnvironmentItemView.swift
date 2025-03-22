import SwiftUI

struct CampEnvironmentItemView: View {
    private var environment: CampEnvironment
    
    init(_ environment: CampEnvironment) {
        self.environment = environment
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.black)
                .frame(width: 200, height: 200)
            
            Button {
                
            } label: {
                Text(environment.rawValue)
                    .padding(.vertical, 16)
            }
            .padding(16)
        }
    }
}

#Preview {
    CampEnvironmentItemView(.spring)
}
