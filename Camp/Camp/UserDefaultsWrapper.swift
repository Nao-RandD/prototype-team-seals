import Foundation

final class UserDefaultsWrapper {
    enum Key: String {
        case campEnvironment = "camp_environment"
    }
    
    static func saveCampEnvironment(_ environment: CampEnvironment) {
        UserDefaults.standard.setValue(environment.rawValue, forKey: Key.campEnvironment.rawValue)
    }
    
    static func campEnvironment() -> CampEnvironment {
        let environment = UserDefaults.standard.string(forKey: Key.campEnvironment.rawValue) ?? ""
        return CampEnvironment(rawValue: environment) ?? .spring
    }
}
