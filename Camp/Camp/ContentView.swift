//
//  ContentView.swift
//  Camp
//
//  Created by TAAT on 2025/03/22.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    var body: some View {
        VStack(spacing: 40) {
            Text("Spacial Camp ")
                .font(.extraLargeTitle)
            
            Model3D(named: "Immersive", bundle: realityKitContentBundle) { model in
                model
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
                    .rotation3DEffect(.init(radians: .pi), axis: (x: 0, y: 1, z: 0))
            } placeholder: {
                ProgressView()
            }
            
            ToggleImmersiveSpaceButton()
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
