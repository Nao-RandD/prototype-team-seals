import SwiftUI

enum CampEnvironment: String, CaseIterable {
    var id: String { rawValue }
    
    case spring = "Spring"
    case summer = "Summer"
    case autumn = "Autumn"
    case winter = "Winter"

    var skyboxName: String {
        switch self {
        case .spring, .autumn, .winter:
            return "CartoonBaseBlueSky"
        case .summer:
            return "CartoonBaseNightSky"
        }
    }

    var localizedString: String {
            switch self {
            case .spring:
                return String(localized: "Spring", defaultValue: "Spring")
            case .summer:
                return String(localized: "Summer", defaultValue: "Summer")
            case .autumn:
                return String(localized: "Autumn", defaultValue: "Autumn")
            case .winter:
                return String(localized: "Winter", defaultValue: "Winter")
            }
        }

    var imageName: String {
        "Tree_" + self.rawValue
    }
    
    var particleName: String {
        let name = switch self {
        case .spring:
            "CherryBlossomParticle"
        case .summer:
            "FireflyParticle"
        case .autumn:
            "MapleLeafParticle"
        case .winter:
            "SnowParticle"
        }
        return "Particles/\(name)"
    }
    
    var environmentName: String {
        "Environments/\(rawValue)"
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
        true
    }
}
