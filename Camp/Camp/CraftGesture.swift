import SwiftUI
import RealityKit

/// A gesture modifier handling drag, rotate, magnify gestures.
struct CraftGesture: ViewModifier {
    private let moveSpeed: Float = 0.5

    @State var isActive: Bool = false	
    @State var initialPosition: SIMD3<Float> = .zero
    @State var initialScale: SIMD3<Float> = .one
    @State var initialOrientation:simd_quatf = simd_quatf(vector: .zero)

    var onGestureEnded: (Craft) -> Void
    
    func body(content: Content) -> some View {
        content
            .gesture(dragGesture)
            .gesture(rotateGesture)
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                startGesture(with: value.entity)
                
                // Update position from drag gesture
                let movement = value.convert(value.gestureValue.translation3D, from: .local, to: .scene)
                var newPosition = initialPosition + movement * moveSpeed
                
                // Fix entities on the ground
                newPosition.y = 0
                
                value.entity.position = newPosition
            }
            .onEnded { value in
                endGesture()
                onGestureEnded(.init(entity: value.entity))
            }
    }
    
    var rotateGesture: some Gesture {
        RotateGesture3D(constrainedToAxis: .y)
            .targetedToAnyEntity()
            .onChanged { value in
                startGesture(with: value.entity)
                
                guard initialOrientation.length > 0 else { return }
                
                // Update rotation from rotate gesture
                let rotationTransform = Transform(AffineTransform3D(rotation: value.rotation))
                value.entity.orientation = initialOrientation * rotationTransform.rotation
            }
            .onEnded { value in
                endGesture()
                onGestureEnded(.init(entity: value.entity))
            }
    }
    
    var rotateAndMagnifyGesture: some Gesture {
        RotateGesture3D(constrainedToAxis: .y)
            .simultaneously(with: MagnifyGesture())
            .targetedToAnyEntity()
            .onChanged { value in
                startGesture(with: value.entity)
                
                guard initialOrientation.length > 0 else { return }
                
                if let rotation = value.first?.rotation, let magnification = value.second?.magnification {
                    // Update rotation from rotate gesture
                    let rotationTransform = Transform(AffineTransform3D(rotation: rotation))
                    value.entity.orientation = initialOrientation * rotationTransform.rotation
                    
                    // Update scale from magnify gesture
                    let newScale = initialScale * Float(magnification)
                    value.entity.scale = newScale
                }

            }
            .onEnded { value in
                endGesture()
                onGestureEnded(.init(entity: value.entity))
            }
    }
    
    private func startGesture(with entity: Entity) {
        guard !isActive else { return }
        
        isActive = true
        
        // Cache the entity's initial position, scale and rotation
        initialPosition = entity.position
        initialScale = entity.scale
        initialOrientation = entity.transform.rotation
    }
    
    private func endGesture() {
        guard isActive else { return }
        
        isActive = false
        
        // Reset the entity's initial position, scale and rotation
        initialPosition = .zero
        initialScale = .one
        initialOrientation = simd_quatf(vector: .zero)
    }
}

extension View {
    func craftGesture(onGestureEnded: @escaping (Craft) -> Void) -> some View {
        modifier(CraftGesture(onGestureEnded: onGestureEnded))
    }
}
