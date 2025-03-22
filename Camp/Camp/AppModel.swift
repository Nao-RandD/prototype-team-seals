import SwiftUI

/// Maintains app-wide state
@MainActor
@Observable
class AppModel {
    let titleWindowID = "TitleWindow"
    let environmentSelectionWindowID = "EnvironmentSelectionWindow"
    let immersiveSpaceID = "ImmersiveSpace"
    
    enum WindowState {
        case closed
        case open
    }
    
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    var immersiveSpaceState = ImmersiveSpaceState.closed
    
    func changeImmersiveSpaceState(_ state: ImmersiveSpaceState) {
        immersiveSpaceState = state
    }
    
    var isImmersiveSpaceOpen: Bool {
        immersiveSpaceState == .open
    }
    
    var isImmersiveSpaceInTransition: Bool {
        immersiveSpaceState == .inTransition
    }
    
    var isImmersiveSpaceClosed: Bool {
        immersiveSpaceState == .closed
    }
}
