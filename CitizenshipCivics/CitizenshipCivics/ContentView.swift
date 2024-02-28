
//  ContentView.swift
//  CitizenshipCivics
//
//  Created by Uttarkar, Kiran on 2/2/24.


import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    //    @State private var showImmersiveSpace = false
    //    @State private var immersiveSpaceIsShown = false
        @Environment(\.openImmersiveSpace) var openImmersiveSpace
        @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
        @State private var fadeOut = false

        var body: some View {
            VStack(alignment: .leading, content: {
                Text("")
            })
            .onAppear(perform: {
                Task {
                    await openImmersiveSpace(id: "ImmersiveView") // try open this ISp
                }
            }) // onAppear end
        } // var body end
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
