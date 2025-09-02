//
//  Constants.swift
//  HP Trivia
//
//  Created by Станислав Леонов on 01.09.2025.
//

import Foundation
import SwiftUI

enum Contstants {
    static let hpFont = "PartyLetPlain"
}

struct InfoBackgroundImage: View {
    var body: some View {
        Image("parchment")
            .resizable()
            .ignoresSafeArea()
            .background(.brown)
    }
}

extension Button {
    func doneBotton() ->  some View {
        self
            .font(.largeTitle)
            .buttonStyle(.borderedProminent)
            .tint(.brown)
            .foregroundStyle(.white)
    }
}
