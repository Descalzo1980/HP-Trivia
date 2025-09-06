//
//  Game.swift
//  HP Trivia
//
//  Created by Станислав Леонов on 06.09.2025.
//

import Foundation

@MainActor
class Game: ObservableObject {
    private var allQuestion: [Question] = []
    private var answeredQuestion: [Int] = []
    
    var filteredQuestion: [Question] = []
    var currentQuestion = Constants.previewQuestion
    var answers: [String] = []
    
    var correctAnswer: String {
        currentQuestion.answers.first(where: {$0.value == true })!.key
    }
    
    init() {
        decodeQuestion()
    }
    
    func filterQuestion(to books: [Int]) {
        filteredQuestion = allQuestion.filter { books.contains($0.book) }
    }
    
    func newQuestion() {
        if filteredQuestion.isEmpty {
            return
        }
        if answeredQuestion.count == filteredQuestion.count {
            answeredQuestion = []
        }
        var potentialQuestion = filteredQuestion.randomElement()!
        while answeredQuestion.contains(potentialQuestion.id) {
            potentialQuestion = filteredQuestion.randomElement()!
        }
        currentQuestion = potentialQuestion
        
        answers = []
        
        for answer in currentQuestion.answers.keys {
            answers.append(answer)
        }
        
        answers.shuffle()
    }
    
    func correct() {
        answeredQuestion.append(currentQuestion.id)
    }
    
    private func decodeQuestion() {
        if let url = Bundle.main.url(forResource: "trivia", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                allQuestion = try decoder.decode([Question].self, from: data)
                filteredQuestion = allQuestion
            }catch {
                print("Error decoded JSON data: \(error)")
            }
        }
    }
}
