//
//  ContentView.swift
//  Project2
//
//  Created by Oritsegbe T. Nanna on 10/26/19.
//  Copyright © 2019 Oritsegbe T.  Nanna. All rights reserved.
//

import SwiftUI

struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}





struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0 ... 2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var correctScoreInt: Int = 0
    @State private var wrongScoreInt: Int = 0
    
    var correctScore: String {
        let correctTemp = String(correctScoreInt)
        return correctTemp
    }
    
    var wrongScore: String {
        let wrongTemp = String(wrongScoreInt)
        return wrongTemp
    }
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                VStack(spacing: 30) {
                    VStack {
                        Text("Guess the flag of...")
                            .foregroundColor(.white)
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            self.flagTapped(number)
                        }) {
                            Image(self.countries[number])
                                .renderingMode(.original)
                            .modifier(FlagImage())
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Correct: \(correctScore)")
                        Text("Wrong: \(wrongScore)")
                    }.foregroundColor(.white).frame(width: 300)
                    Spacer()
                }
                .alert(isPresented: $showingScore) {
                    Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                        self.askQuestion()
                        })
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreMessage = ""
            correctScoreInt += 1
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "Wrong! That’s the flag of \(countries[number])"
            wrongScoreInt += 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
