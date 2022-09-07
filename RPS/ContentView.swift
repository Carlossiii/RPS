//
//  ContentView.swift
//  RPS
//
//  Created by Carlos Vinicius on 05/09/22.
//

import SwiftUI

struct RPSIcon: View {
    var rps: [String]
    var number: Int
    
    var body: some View {
        
        Image(rps[number])
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 10)
            .fixedSize(horizontal: true, vertical: true)
    }
}

struct ContentView: View {
    @State private var scoreNow = 0
    @State private var attempt = 1
    @State private var scoreAfter = 0
    @State private var scoreTitle = ""
    @State private var textLast = ""
    @State private var showingScore = false
    @State private var lastAttempt = false
    
    @State private var RPSArray = ["Rock", "Paper", "Scissor"]
    @State private var appChoosen = Int.random(in: 0...2)
    @State private var winOrLose = Bool.random()
    
    
    var body: some View {
        ZStack {
            RadialGradient (stops: [
                    .init(color: Color(red: 0.7, green: 0.2, blue: 0.1), location: 0.3),
                    .init(color: Color(red: 0.15, green: 0.15, blue: 0.2), location: 0.3)
            ], center: .top, startRadius: 150, endRadius: 500)
                        .ignoresSafeArea()
            
            VStack (spacing: 10) {
                Spacer()
                
                Text("Rock, paper and scissors!")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                HStack (spacing: 150) {
                    Text (" Score: \(scoreNow) ")
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Text (" Attempt: \(attempt) ")
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .font(.title3.bold())
                .foregroundColor(.white)
                
                VStack {
                    HStack (spacing: 15){
                        Text ("Move: \(RPSArray[appChoosen])")
                        Text ("|")
                        Text ("Should: \(winOrLose == true ? "Win" : "Lose")")
                    }
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    
                    ForEach(0..<3) { number in
                        Button {
                            RPSTapped(number)
                        } label: {
                            RPSIcon(rps: RPSArray, number: number)
                        }
                    }
                }
                
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            .padding()
            }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action:  askQuestion)
        } message: {
            Text("Your current score is \(scoreNow).")
        }
        .alert(textLast, isPresented: $lastAttempt) {
            Button("Reset", role: .destructive, action: reset)
        } message: {
            Text("You scored \(scoreAfter) points!")
        }
    }
    
    func RPSTapped (_ number: Int) {
        
        if attempt < 10 {
            checkGame(number)
            attempt += 1
            showingScore = true
            lastAttempt = false
        } else {
            checkGame(number)
            reset()
        }
    }
    
    func askQuestion() {
        appChoosen = Int.random(in: 0...2)
        winOrLose.toggle()
    }
    
    func reset() {
        textLast = "Game over!"
        scoreAfter = scoreNow
        scoreNow = 0
        attempt = 1
        lastAttempt = true
    }
    
    func checkGame(_ number: Int) {
        if winOrLose {
            if RPSArray[appChoosen] == "Rock" {
                if RPSArray[number] == "Paper" {
                    scoreNow += 1
                    scoreTitle = "Correct!"
                } else {
                    scoreTitle = "Wrong!"
                    scoreNow -= 1
                }
            } else if RPSArray[appChoosen] == "Scissor" {
                if RPSArray[number] == "Rock" {
                    scoreTitle = "Correct!"
                    scoreNow += 1
                } else {
                    scoreTitle = "Wrong!"
                    scoreNow -= 1
                }
            } else if RPSArray[appChoosen] == "Paper" {
                if RPSArray[number] == "Scissor" {
                    scoreTitle = "Correct!"
                    scoreNow += 1
                } else {
                    scoreTitle = "Wrong!"
                    scoreNow -= 1
                }
            }
        } else {
            if RPSArray[appChoosen] == "Rock" {
                if RPSArray[number] == "Scissor" {
                    scoreTitle = "Correct!"
                    scoreNow += 1
                } else {
                    scoreTitle = "Wrong!"
                    scoreNow -= 1
                }
            } else if RPSArray[appChoosen] == "Scissor" {
                if RPSArray[number] == "Paper" {
                    scoreTitle = "Correct!"
                    scoreNow += 1
                } else {
                    scoreTitle = "Wrong!"
                    scoreNow -= 1
                }
            } else if RPSArray[appChoosen] == "Paper" {
                if RPSArray[number] == "Rock" {
                    scoreTitle = "Correct!"
                    scoreNow += 1
                } else {
                    scoreTitle = "Wrong!"
                    scoreNow -= 1
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
