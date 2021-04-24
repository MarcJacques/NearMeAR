//
//  ARView.swift
//  NearMeAR
//
//  Created by Marc Jacques on 4/24/21.
//

import SwiftUI
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}

}


struct ARViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        ARViewContainer()
    }
}
