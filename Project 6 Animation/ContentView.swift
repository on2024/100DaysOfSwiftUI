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
    @State private var animationAmount = 0.0
    @State private var rowZeroTest = false
    @State private var rowTwoTest = false
    @State private var rowOneTest = false
    @State private var testAnswer = ""
    // initial opacity for animation was set to 1.75 to account for decrease in opacity after animation
    @State private var rowZeroOpacity = 1.75
    @State private var rowOneOpacity = 1.75
    @State private var rowTwoOpacity = 1.75
    @State private var wrong = false


   
    
    
    
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
            LinearGradient(gradient: Gradient(colors: [(wrong ? .red : .blue ), .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                .animation(.easeIn)
                VStack(spacing: 30) {
                    VStack {
                        Text("Guess the flag of...")
                            .foregroundColor(.white)
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    
                    
                    Button(action: {
                        self.flagTapped(0)
                        withAnimation() {
                            self.animationAmount += 360
                            self.rowZeroOpacity -= (0 != self.correctAnswer ? 0.75 : -0.75)
                            if 0 != self.correctAnswer {
                                self.wrong.toggle()
                            }
                        }
                        
                    }) {
                        Image(self.countries[0])
                        .renderingMode(.original)
                        .modifier(FlagImage())
                            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0)).opacity(rowZeroOpacity)
                            .animation( rowZeroTest ? .default : nil )
                        
                        
                    }
                    
                    
                    Button(action: {
                        self.flagTapped(1)
                        withAnimation() {
                            self.animationAmount += 360
                            self.rowOneOpacity -= (1 != self.correctAnswer ? 0.75 : -0.75)
                            if 1 != self.correctAnswer {
                                self.wrong.toggle()
                            }
                        }
                    }) {
                        Image(self.countries[1])
                        .renderingMode(.original)
                        .modifier(FlagImage())
                            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0)).opacity(rowOneOpacity)
                            .animation( rowOneTest ? .default : nil )
                    }
                    
                    Button(action: {
                        self.flagTapped(2)
                        withAnimation() {
                            self.animationAmount += 360
                            self.rowTwoOpacity -= (2 != self.correctAnswer ? 0.75 : -0.75)
                            if 2 != self.correctAnswer {
                                self.wrong.toggle()
                            }
                        }
                    }) {
                        Image(self.countries[2])
                        .renderingMode(.original)
                        .modifier(FlagImage())
                            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0)).opacity(rowTwoOpacity)
                            .animation( rowTwoTest ? .default : nil )
                        
                    }
                 
                    VStack(alignment: .leading) {
                        Text("Correct: \(correctScore)")
                        Text("Wrong: \(wrongScore)")
                    }.foregroundColor(.white).frame(width: 300)
                        .font(.headline)
                    
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
        testAnswer = String(number)
        switch testAnswer {
        case "0":
            if number == correctAnswer {
                rowZeroTest = true
            } else {
                rowZeroTest = false
            }
            rowOneTest = false
            rowTwoTest = false
        case "1":
            rowZeroTest = false
            if number == correctAnswer {
                rowOneTest = true
            } else {
                rowOneTest = false
            }
            rowTwoTest = false
        case "2":
            rowZeroTest = false
            rowOneTest = false
            if number == correctAnswer {
                rowTwoTest = true
            } else {
                rowTwoTest = false
            }
        default:
            rowZeroTest = true
            rowOneTest = true
            rowTwoTest = true
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
        rowZeroOpacity = 1.75
        rowOneOpacity = 1.75
        rowTwoOpacity = 1.75
        wrong = false
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
