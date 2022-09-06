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
            .shadow(radius: 5)
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
        VStack{
            VStack (spacing: 10){
                Text ("Your score is: \(scoreNow)")
                Text ("App move is: \(RPSArray[appChoosen])")
                Text ("You should now: \(winOrLose == true ? "Win" : "Lose")")
                Text ("Attempt: \(attempt)")
            }
            
            ForEach(0..<3) { number in
                Button {
                    RPSTapped(number)
                } label: {
                    RPSIcon(rps: RPSArray, number: number)
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action:  askQuestion)
        } message: {
            Text("Your score is \(scoreNow).")
        }
        .alert(textLast, isPresented: $lastAttempt) {
            Button("Reset", role: .destructive, action: reset)
        } message: {
            Text("This was your last round. \n Your score is \(scoreAfter)!")
        }
    }
    
    func RPSTapped (_ number: Int) {
        
        if attempt < 10 {
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
            attempt += 1
            showingScore = true
        } else {
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
