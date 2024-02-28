//
//  ImmersiveView.swift
//  CitizenshipCivics
//
//  Created by Uttarkar, Kiran on 2/2/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    //    @State var characterEntity: Entity = {
    //        let headAnchor = AnchorEntity(.head)
    //        headAnchor.position = [0.10, -0.4, -0.80]
    //        let radians = -20 * Float.pi / 180
    //        ImmersiveView.rotateEntityAroundYAxis(entity: headAnchor, angle: radians)
    //        return headAnchor
    //    }()
        
        @State var isClicked: Bool = false
        @State var counter: Int = 0
        @Environment(\.openWindow) var openWindow
        @Environment(\.dismissWindow) var dismissWindow
        
        var body: some View {
            RealityView { content, attachments in
                do {
                    let immersiveEntity = try await Entity(named: "Immersive", in: realityKitContentBundle)
                    immersiveEntity.position = [0, 0, -0.1]
                    let radians = -5 * Float.pi / 180
                    ImmersiveView.rotateEntityAroundYAxis(entity: immersiveEntity, angle: radians)
                    content.add(immersiveEntity)
                    
                    // attachments
                    guard let attachmentEntity = attachments.entity(for: "plane") else { return }
                    attachmentEntity.position = [0,1.6,-0.2]
                    immersiveEntity.addChild(attachmentEntity)
                } catch {
                    print("Error loading content: \(error)")
                }
                } update: { _, _ in
                } attachments: {
                    Attachment(id: "plane") {
                        VStack {
                            AutoScroller()
                        }
                    }
                }
            }
    
        
        static func rotateEntityAroundYAxis(entity: Entity, angle: Float){
            // Get current transform of the entity
            var currentTransform = entity.transform
            
            // Create a quaternion representing a rotation around the Y-axis
            let rotation = simd_quatf(angle: angle, axis: [0, 1, 0])
            
            // Combine the rotation with the current transform
            currentTransform.rotation = rotation * currentTransform.rotation
            
            // Apply the new transform to the entity
            entity.transform = currentTransform
        }
        
        
        static func loadImageMaterial(ImageUrl: String) -> SimpleMaterial {
            do {
                let texture = try TextureResource.load(named: ImageUrl)
                var material = SimpleMaterial()
                let color = SimpleMaterial.BaseColor(texture:
                                                        MaterialParameters.Texture(texture))
                material.color = color
                return material
            } catch {
                fatalError(String(describing: error))
            }
        }
        
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
