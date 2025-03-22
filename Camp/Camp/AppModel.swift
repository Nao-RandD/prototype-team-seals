import SwiftUI

/// Maintains app-wide state
@MainActor
@Observable
class AppModel {
    enum WindowType {
        case title
        case environmentSelection
    }
    
    enum WindowState {
        case closed
        case open
    }
    
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    
    let titleWindowID = "TitleWindow"
    let immersiveMenuWindowID = "ImmersiveMenuWindow"
    let environmentSelectionWindowID = "EnvironmentSelectionWindow"
    let immersiveSpaceID = "ImmersiveSpace"

    let soundStorage = SoundStorage()
    
    var immersiveSpaceState = ImmersiveSpaceState.closed
    var campEnvironment: CampEnvironment = UserDefaultsWrapper.campEnvironment()
    
    private var titleWindowState = WindowState.closed
    private var environmentSelectionWindowState = WindowState.closed
}

extension AppModel {
    func changeWindowState(_ state: WindowState, type: WindowType) {
        switch type {
        case .title:
            titleWindowState = state
        case .environmentSelection:
            environmentSelectionWindowState = state
        }
    }
    
    func isWindowOpen(type: WindowType) -> Bool {
        switch type {
        case .title:
            return titleWindowState == .open
        case .environmentSelection:
            return environmentSelectionWindowState == .open
        }
    }
    
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
