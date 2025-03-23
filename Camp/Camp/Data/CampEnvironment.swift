import SwiftUI

enum CampEnvironment: String, CaseIterable {
    var id: String { rawValue }
    
    case spring = "Spring"
    case summer = "Summer"
    case autumn = "Autumn"
    case winter = "Winter"

    var skyboxName: String {
        "Skybox_" + self.rawValue
    }
    
    var imageName: String {
        "Tree_" + self.rawValue
    }
    
    var color: Color {
        switch self {
        case .spring:
            return .pink
        case .summer:
            return .green
        case .autumn:
            return .yellow
        case .winter:
            return .blue
        }
    }
    
    var isAvailable: Bool {
        switch self {
        case .spring, .summer:
            return true
        case .autumn, .winter:
            return false
        }
    }
}
