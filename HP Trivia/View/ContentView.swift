//
//  ContentView.swift
//  HP Trivia
//
//  Created by Станислав Леонов on 01.09.2025.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @EnvironmentObject private var store: Store
    @EnvironmentObject private var game: Game
    @State private var audioPlayer: AVAudioPlayer!
    @State private var scalePlayButton = false
    @State private var moveBackgroundImage = false
    @State private var animationViewsIn = false
    @State private var showInstructions = false
    @State private var showSettings = false
    @State private var playGame = false
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height)
                    .padding(.top, 3)
                    .offset(x: moveBackgroundImage ? geo.size.width/1.1 : -geo.size.width/1.1)
                    .onAppear {
                        withAnimation(.linear(duration: 60).repeatForever()) {
                            moveBackgroundImage.toggle()
                        }
                    }
                
                VStack {
                    VStack {
                        if animationViewsIn {
                            VStack {
                                Image(systemName: "bolt.fill")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                
                                Text("HP")
                                    .font(.custom(Constants.hpFont, size: 70))
                                    .padding(.bottom, -50)
                                
                                Text("Trivia")
                                    .font(.custom(Constants.hpFont, size: 60))
                            }
                            .padding(.top, 70)
                            .transition(.move(edge: .top))
                        }
                    }
                    .animation(.easeOut(duration: 1).delay(1), value: animationViewsIn)
                    
                    Spacer()
                    VStack {
                        if animationViewsIn {
                            VStack {
                                Text("Recent Scores")
                                    .font(.title2)
                                
                                Text("33")
                                Text("27")
                                Text("15")
                            }
                            .font(.title3)
                            .padding(.horizontal)
                            .foregroundStyle(.white)
                            .background(.black.opacity(0.7))
                            .cornerRadius(15)
                            .transition(.opacity)
                        }
                    }.animation(.linear(duration: 3).delay(2), value: animationViewsIn)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        VStack {
                            if animationViewsIn {
                                Button {
                                    showInstructions.toggle()
                                } label: {
                                    Image(systemName: "info.circle.fill")
                                        .font(.largeTitle)
                                        .tint(.white)
                                        .shadow(radius: 5)
                                }
                                .transition(.offset(x: -geo.size.width / 4))
                            }
                        }.animation(.easeOut(duration: 1).delay(1), value: animationViewsIn)
                            .sheet(isPresented: $showInstructions) {
                                Instructions()
                            }
                        Spacer()
                        VStack {
                            if animationViewsIn {
                                Button {
                                    filterQuestion()
                                    game.startGame()
                                    playGame.toggle()
                                } label: {
                                    Text("Play")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                        .padding(.vertical, 7)
                                        .padding(.horizontal, 50)
                                        .background(store.books.contains(.active) ? .brown : .gray)
                                        .cornerRadius(7)
                                        .shadow(radius: 5)
                                }
                                .scaleEffect(scalePlayButton ? 1.2 : 1)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 1.3).repeatForever()) {
                                        scalePlayButton.toggle()
                                    }
                                }
                                .transition(.offset(y: geo.size.height / 3))
                                .fullScreenCover(isPresented: $playGame) {
                                    Gameplay()
                                        .environmentObject(game)
                                }
                                .disabled(store.books.contains(.active) ? false : true)
                            }
                        }
                        .animation(.easeOut(duration: 1).delay(1), value: animationViewsIn)
                        
                        Spacer()
                        VStack {
                            if animationViewsIn {
                                Button {
                                    showSettings.toggle()
                                } label: {
                                    Image(systemName: "gearshape.fill")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                        .shadow(radius: 5)
                                }
                                .transition(.offset(x: geo.size.width / 4))
                                .sheet(isPresented: $showSettings) {
                                    Settings()
                                        .environmentObject(store)
                                }
                            }
                        }
                        .animation(.easeOut(duration: 1).delay(1), value: animationViewsIn)
                        Spacer()
                    }
                    .frame(width: geo.size.width)
                    
                    VStack {
                        if animationViewsIn {
                            if store.books.contains(.active) == false {
                                Text("No question available. Go to settings.⬆️")
                                    .multilineTextAlignment(.center)
                                    .transition(.opacity)
                            }
                        }
                    }
                    .animation(.easeInOut.delay(3), value: animationViewsIn)
                    
                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear() {
            playAudio()
            animationViewsIn = true
        }
    }
    
    private func playAudio() {
        let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
    
    private func filterQuestion() {
        var books: [Int] = []
        for (index, status) in store.books.enumerated() {
            if status == .active {
                books.append(index+1)
            }
        }
        game.filterQuestion(to: books)
        game.newQuestion()
    }
}

//#Preview {
//    ContentView()
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ContentView()
                .environmentObject(Store())
                .environmentObject(Game())
        }
    }
}
