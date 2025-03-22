enum CampEnvironment: String, CaseIterable {
    var id: String { rawValue }
    
    case spring = "Spring"
    case summer = "Summer"
    case autumn = "Autumn"
    case winter = "Winter"
    case space = "Space"

    var skyboxName: String {
        "Skybox_" + self.rawValue
    }
}
