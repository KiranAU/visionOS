//
//  Question.swift
//  CitizenshipCivics
//
//  Created by Uttarkar, Kiran on 2/2/24.
//

import Foundation

// Data model. struct define properties and functions. We use it instead of enum becuase we don't have known amount of the queestions / the data could change

struct Question: Decodable, Identifiable, Hashable {
    let id: Int
    let question: String
    let answer: String
    let imageUrl: String?
    let videoUrl: String?
}
