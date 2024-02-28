//
//  ViewModel.swift
//  CitizenshipCivics
//
//  Created by Uttarkar, Kiran on 2/2/24.
//

import Foundation
import Observation


enum FlowState { // represents different states the app could be in
    case idle
    case intro
    case projectileFlying
    case updateCitizenshipCivicsApp
}

@Observable // replaces Observable object listen to this state from view
class ViewModel {
    var flowState = FlowState.idle
    
}
