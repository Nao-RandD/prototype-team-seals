//
//  EffectSound.swift
//  Camp
//
//  Created by Nao RandD on 2025/03/22.
//

import Foundation

enum EffectSound: CaseIterable {
    case bbq
    case bugs
    case openFire

    var resourceName: String {
        switch self {
        case .bbq:
            "effect1-text-typing"
        case .bugs:
            "effect2-trans-environment"
        case .openFire:
            "effect3-start-preparing"
        }
    }
}

enum BackgroundSound: CaseIterable {
    case pianoSound
    case animalCrossing
    case violinSound

    var resourceName: String {
        switch self {
        case .pianoSound:
            "bgm-1"
        case .animalCrossing:
            "bgm-2"
        case .violinSound:
            "bgm-3"
        }
    }
}
