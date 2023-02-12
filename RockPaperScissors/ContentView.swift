//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Nick Pavlov on 2/12/23.
//

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

struct ContentView: View {
    @State private var currentChoise = 0
    @State private var winOrLose = Bool.random()
    @State private var totalScore = 0
    @State private var showingScore = false
    @State private var randomComputeChoise = Int.random(in: 0...2)
    
    let possibleMoves = ["✂️", "📃", "🗿"]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .orange]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 100) {
                Text("Rock Paper Scissors")
                    .modifier(DrawText())
                VStack(spacing: 50) {
                    
                    DrawHorizontalText(text: "Your score is: ", textResult: "\(totalScore)")
                    
                    DrawImageView(imageName: "\(possibleMoves[randomComputeChoise])")
                    
                    DrawHorizontalText(text: "You must ", textResult: winOrLose ? "Win": "Lose")
                    
                    HStack {
                        ForEach(0..<possibleMoves.count, id: \.self) { number in
                            Button(action: {
                                checkToWin(selectedName: self.possibleMoves[number])
                            }) {
                                DrawImageView(imageName: "\(self.possibleMoves[number])")
                            }
                        }
                    }
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) { () -> Alert in
            Alert(title: Text("You WIN"), message: Text("Your score is \(self.totalScore)"), dismissButton: .default(Text("New Game")) {
                self.totalScore = 0
                self.winOrLose = Bool.random()
                self.randomComputeChoise = Int.random(in: 0...2)
            })
        }
    }
    
    func checkToWin(selectedName: String) {
        guard let index = possibleMoves.firstIndex(where: { return $0 == possibleMoves[randomComputeChoise]}) else { return }
        let prefixArray = possibleMoves.prefix(upTo: index)
        let suffixArray = possibleMoves.suffix(from: index)
        
        let wrappedArray = suffixArray + prefixArray
        
        guard let comoutedIndex = wrappedArray.firstIndex(where: { return $0 == possibleMoves[randomComputeChoise]}) else { return }
        guard let selectedIndex = wrappedArray.firstIndex(where: { return $0 == selectedName}) else { return }
        
        if winOrLose {
            totalScore += comoutedIndex + 1 == selectedIndex ? 1 : 0
        } else {
            totalScore += !(comoutedIndex + 1 == selectedIndex) ? 1 : 0
        }
        
        self.winOrLose = Bool.random()
        self.randomComputeChoise = Int.random(in: 0...2)
        
        // Run new game
        runnewGame()
    }
    
    func runnewGame() {
        if self.totalScore == 10 {
            self.showingScore = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
