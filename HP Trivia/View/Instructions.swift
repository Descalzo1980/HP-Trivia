//
//  Instructions.swift
//  HP Trivia
//
//  Created by Станислав Леонов on 02.09.2025.
//

import SwiftUI

struct Instructions: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            InfoBackgroundImage()
            
            VStack {
                Image("appiconwithradius")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding(.top)
                
                ScrollView {
                    Text("How To Play")
                        .font(.largeTitle)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Welcome to HP Trivia! In this game, you will be asked random questions from HP books and you must guess the right answer or you will lose points!😱")
                            .padding([.horizontal, .bottom])
                        
                        Text("Each questions is worth 5 points, but if you guess a wrong answer, you lose 1 point.")
                            .padding([.horizontal, .bottom])
                        
                        Text("If you are struggling with a question, there is a option to reveal a hint or reveal the book that answers the question. But beware! Using these also minuses 1 point each.")
                            .padding([.horizontal, .bottom])
                        
                        Text("When you select the correct answer, you will be awarded all the points left for that question and they will be added to your total score.")
                            .padding(.horizontal)
                    }
                    .font(.title3)
                    
                    Text("Good Luck!")
                        .font(.title)
                }
                .foregroundStyle(.black)
                
                Button("Done") {
                    dismiss()
                }
                .doneBotton()
            }
        }
    }
}

#Preview {
    Instructions()
}
