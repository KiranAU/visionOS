//
//  Questions.swift
//  CitizenshipCivics
//
//  Created by Uttarkar, Kiran on 2/2/24.
//

import Foundation
// Manipulates the data. Logic to manipulate the data. Class because it's hard to change properties of a struct once they are set.

class Questions {
    var testQuestions: [Question] = []
    
    init(){
        decodeQuestionData()
    }
    
    func decodeQuestionData(){
        if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                testQuestions = try decoder.decode([Question].self, from: data)
            } catch {
                print("Errror decoding JSON data: \(error)")
            }
        }
    }
}
