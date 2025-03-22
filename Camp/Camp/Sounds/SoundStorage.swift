//
//  EffectSound.swift
//  Camp
//
//  Created by Nao RandD on 2025/03/22.
//

import RealityKit

@MainActor
final class SoundStorage {
    var soundEntity = Entity()
    var backgroundSoundResource: [BackgroundSound: AudioFileResource] = [:]
    var effectSoundResource: [EffectSound: AudioFileResource] = [:]

    func load() async throws {
        try await withThrowingTaskGroup(of: Void.self) { taskGroup in
            for backgroundSound in BackgroundSound.allCases {
                backgroundSoundResource[backgroundSound] = try await AudioFileResource(
                    named: backgroundSound.resourceName,
                    configuration: .init(
                        shouldLoop: true
                    )
                )
            }
        }
        try await withThrowingTaskGroup(of: Void.self) { taskGroup in
            for effectSound in EffectSound.allCases {
                effectSoundResource[effectSound] = try await AudioFileResource(
                    named: effectSound.resourceName
                )
            }
        }
    }

    func play(sound: BackgroundSound) async {
        guard let resource = backgroundSoundResource[sound] else { return }
        soundEntity.components.set(SpatialAudioComponent())
        let controller = soundEntity.prepareAudio(resource)

        controller.play()
        controller.gain = -.infinity
        controller.fade(to: 0, duration: 1)
    }

    func play(effectSound: EffectSound) {
        guard let resource = effectSoundResource[effectSound] else { return }
        soundEntity.components.set(SpatialAudioComponent())
        let controller = soundEntity.prepareAudio(resource)
        controller.play()
        controller.gain = 0
    }

    func play(from entity: Entity, effectSound: EffectSound) {
        guard let resource = effectSoundResource[effectSound] else { return }
        entity.stopAllAudio()
        let controller = entity.prepareAudio(resource)
        controller.play()
    }

    func stopAllAudio() {
        soundEntity.stopAllAudio()
    }
}
