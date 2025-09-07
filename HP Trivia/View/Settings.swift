//
//  Settings.swift
//  HP Trivia
//
//  Created by Станислав Леонов on 03.09.2025.
//

import SwiftUI

struct Settings: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var store: Store
    
    var body: some View {
        ZStack {
            InfoBackgroundImage()
            
            VStack {
                Text("Which books would you like to see questions from?")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                ScrollView {
                    LazyVGrid(columns: [GridItem(),GridItem()]) {
                        ForEach(0..<7) { i in
                            let id = "hp\(i+1)"
                            let status = store.books[i]
                            let purchased = store.purchasedIDs.contains(id)
                            if store.books[i] == .active || (store.books[i] == .locked && store.purchasedIDs.contains("hp\(i+1)")){
                                ZStack(alignment: .bottomTrailing) {
                                    Image("hp\(i+1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                    
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .foregroundStyle(.green)
                                        .shadow(radius: 1)
                                        .padding(3)
                                }
                                .onTapGesture {
                                    store.books[i] = .inactive
                                    store.saveStatus()
                                }.task {
                                    store.books[i] = .active
                                    store.saveStatus()
                                }
                                .onAppear {
                                    print("index=\(i), id=\(id), status=\(status), purchased=\(purchased)")
                                }
                            }
                            else if store.books[i] == .inactive {
                                ZStack(alignment: .bottomTrailing) {
                                    Image("hp\(i+1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                        .overlay(Rectangle().opacity(0.33))
                                    
                                    Image(systemName: "circle")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .foregroundStyle(.green.opacity(0.5))
                                        .shadow(radius: 1)
                                        .padding(3)
                                }
                                .onTapGesture {
                                    store.books[i] = .active
                                    store.saveStatus()
                                }
                            }
                            else {
                                ZStack {
                                    Image("hp\(i+1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                        .overlay(Rectangle().opacity(0.75))
                                    
                                    Image(systemName: "lock.fill")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .shadow(color:.white.opacity(0.75), radius: 3)
                                }
                                .onTapGesture {
                                    let id = "hp\(i+1)"
                                    if let product = store.products.first(where: { $0.id == id }) {
                                        Task {
                                            await store.purchase(product)
                                        }
                                    } else {
                                        print("⚠️ Product \(id) not found")
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                Button("Done") {
                    dismiss()
                }
                .doneBotton()
            }
        }
    }
}

#Preview {
    Settings()
        .environmentObject(Store())
}
