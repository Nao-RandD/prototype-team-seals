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
        VStack {
            Text("Spacial Camp ")
                .font(.extraLargeTitle)
            ToggleImmersiveSpaceButton()
            Model3D(named: "Immersive", bundle: realityKitContentBundle)
                .padding(.bottom, 50)
                .scaleEffect(x: 0.5, y: 0.5, z: 0.5)


        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
