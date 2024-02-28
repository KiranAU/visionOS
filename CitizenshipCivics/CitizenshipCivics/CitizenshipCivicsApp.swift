//
//  CitizenshipCivicsApp.swift
//  CitizenshipCivics
//
//  Created by Uttarkar, Kiran on 2/2/24.
//

import SwiftUI

@main
struct CitizenshipCivicsApp: App {
    @State private var viewModel = ViewModel() // persist this instance throughout the app lifecycle
    var body: some Scene {
        ImmersiveSpace(id: "ImmersiveView") { // here we are creating an immersive space with the id "immersiveSpace"
            ImmersiveView()
                .environment(viewModel) // the ContentView has access to the viewModel
        }
        
        WindowGroup{
            ContentView().environment(ViewModel())
        }.windowStyle(.plain)
    }
}
