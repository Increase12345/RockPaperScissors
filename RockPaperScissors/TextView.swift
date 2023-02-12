//
//  TextView.swift
//  RockPaperScissors
//
//  Created by Nick Pavlov on 2/12/23.
//

import Foundation
import SwiftUI

struct DrawText: ViewModifier {
    let font = Font.system(size: 25, weight: .black, design: .default)
    
    func body(content: Content) -> some View {
        content
            .font(font)
    }
}

struct DrawHorizontalText: View {
    var text: String
    var textResult: String
    
    var body: some View {
        HStack {
            Text(text)
                .modifier(DrawText())
                .foregroundColor(.green)
            Text(textResult)
                .modifier(DrawText())
                .foregroundColor(.red)
        }
    }
}

struct DrawImageView: View {
    var imageName: String
    
    var body: some View {
        Text("\(imageName)")
            .padding()
            .padding()
            .background(Color.yellow)
            .cornerRadius(25)
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.red, lineWidth: 2))
            .shadow(color: .blue, radius: 3)
            .font(.largeTitle)
    }
}
