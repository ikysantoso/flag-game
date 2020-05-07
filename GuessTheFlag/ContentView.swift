//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by iky's Macbook Pro on 03/05/20.
//  Copyright © 2020 iky's Macbook Pro. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var userScore = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreDesc = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom) .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                        .clipShape(Capsule())
                        .overlay(Capsule()
                            .stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                Spacer()
            }
            VStack {
                Text("Your score is")
                    .font(.title)
                    .offset(y: 120)
                    .foregroundColor(.white)
                Text("\(userScore)")
                    .offset(y: 150)
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
        
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(scoreDesc), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore = self.userScore + 1
            scoreDesc = """
            Congratulations!
            Now, your score is \(userScore)
            """
        } else {
            scoreTitle = "Wrong"
            scoreDesc = """
            Oops..
            That's not the flag of \(countries[correctAnswer])
            """
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
