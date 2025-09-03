//
//  Gameplay.swift
//  HP Trivia
//
//  Created by Станислав Леонов on 03.09.2025.
//

import SwiftUI

struct Gameplay: View {
    @State private var animationViewsIn = false
    @State private var tappedCorrectAnswer = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height * 1.05)
                    .overlay(Rectangle().foregroundStyle(.black.opacity(0.8)))
                
                VStack {
                    // MARK: Controls
                    HStack {
                        Button("End Game") {
                            // TODO: End game
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red.opacity(0.5))
                        
                        Spacer()
                        
                        Text("Score: 33")
                    }
                    .padding()
                    .padding(.vertical,30)
                    // MARK: Question
                    VStack {
                        if animationViewsIn {
                            Text("Who is Harry Potter?")
                                .font(.custom(Constants.hpFont, size: 50))
                                .multilineTextAlignment(.center)
                                .padding()
                                .transition(.scale)
                        }
                    }
                    .animation(.easeInOut(duration: 2),value: animationViewsIn)
                    
                    Spacer()
                    // MARK: Hints
                    HStack {
                        VStack {
                            if animationViewsIn {
                                Image(systemName: "questionmark.app.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .foregroundStyle(.cyan)
                                    .rotationEffect(.degrees(-15))
                                    .padding()
                                    .padding(.leading, 20)
                                    .transition(.offset(x: -geo.size.width / 2))
                            }
                        }.animation(.easeInOut(duration: 2).delay(1),value: animationViewsIn)
                        
                        Spacer()
                        VStack {
                            if animationViewsIn {
                                Image(systemName: "book.closed")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                    .foregroundStyle(.black)
                                    .frame(width: 100, height: 100)
                                    .background(.cyan)
                                    .cornerRadius(20)
                                    .rotationEffect( .degrees(15))
                                    .padding(.trailing, 20)
                                    .transition(.offset(x: geo.size.width / 2))
                            }
                        }.animation(.easeInOut(duration: 1.5).delay(2),value: animationViewsIn)
                    }
                    .padding(.bottom)
                    
                    // MARK: Answers
                    LazyVGrid(columns: [GridItem(),GridItem()]) {
                        ForEach(1..<5) { i in
                            VStack {
                                if animationViewsIn {
                                    Text(i == 3 ? "The boy who basically lived and got sent to his relatives house where he was treated quite badly, if I'm being honest but yeah." : "Answer \(i)")
                                        .minimumScaleFactor(0.5)
                                        .multilineTextAlignment(.center)
                                        .padding(10)
                                        .frame(width: geo.size.width / 2.15, height: 80)
                                        .background(.green.opacity(0.5))
                                        .cornerRadius(25)
                                        .transition(.slide)
                                }
                            }.animation(.easeInOut(duration: 1.6).delay(2),value: animationViewsIn)
                        }
                    }
                    Spacer()
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .foregroundStyle(.white)
                
                // MARK: Celebration
                VStack {
                    Spacer()
                    
                    VStack {
                        if tappedCorrectAnswer {
                            Text("5")
                                .font(.largeTitle)
                                .padding(.top, 50)
                                .transition(.offset(y: -geo.size.height / 4))
                        }
                    }.animation(.easeInOut(duration: 1).delay(2),value: tappedCorrectAnswer)
                    
                    Spacer()
                    
                    VStack {
                        if tappedCorrectAnswer {
                            Text("Brilliants!")
                                .font(.custom(Constants.hpFont, size: 100))
                                .transition(.scale.combined(with: .offset(y: -geo.size.height / 2)))
                        }
                    }.animation(.easeInOut(duration: 1).delay(1),value: tappedCorrectAnswer)
                    
                    Spacer()
                    Text("Answer 1")
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .frame(width: geo.size.width/2.15, height: 80)
                        .background(.green.opacity(0.5))
                        .cornerRadius(25)
                        .scaleEffect(2)
                    Group {
                        Spacer()
                        Spacer()
                    }
                    
                    VStack {
                        if tappedCorrectAnswer {
                            Button("Next level>") {
                                // TODO: Next game
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.blue.opacity(0.5))
                            .font(.largeTitle)
                            .transition(.offset(y: geo.size.height/3))
                        }
                    }.animation(.easeInOut(duration: 2.7).delay(2.7),value: tappedCorrectAnswer)
                    
                    Group {
                        Spacer()
                        Spacer()
                    }
                }
                .foregroundColor(.white)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear {
            //animationViewsIn = true
            tappedCorrectAnswer = true
        }
    }
}

#Preview {
    VStack {
        Gameplay()
    }
}
