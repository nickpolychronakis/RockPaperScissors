//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by NICK POLYCHRONAKIS on 18/10/19.
//  Copyright © 2019 NICK POLYCHRONAKIS. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    // MARK: - State
    /// Choosing from the optionArray
    @State private var computerChoice = GameOptions.allCases.randomElement()!
    /// If the player has to win or to lose
    @State private var playerShouldWin = Bool.random()
    /// If the game is over, it will show an allert
    @State private var theGameIsOverAlert = false
    /// The game ends at 10 rounds
    @State private var roundOfGame = 1
    /// Score of the game
    @State private var scoreOfTheGame = 0
    
//    @State private var timer = Timer()
    
    
    // MARK: - View
    var body: some View {
        
        VStack {
            // Game statistics Stack
            HStack {
                Text("Round: \(self.roundOfGame)/10")
                Text("Score: \(self.scoreOfTheGame)")
            }
            
            // Message to the user
            Text("iPhones choice is \(computerChoice.rawValue.uppercased()) is and you must \(playerShouldWin ? "WIN" : "LOSE")!" )

            
            // Button Stack
            HStack {
                Button(action: {
                    guard self.computerChoice != .Rock else { return }
                    self.buttonTapped(.Rock)
                }) {
                    Image(systemName: "capsule").font(Font.system(size: 50))
                }
                .padding()
                .layoutPriority(1)
                
                Button(action: {
                    guard self.computerChoice != .Scissors else { return }
                    self.buttonTapped(.Scissors)
                }) {
                    Image(systemName: "scissors").font(Font.system(size: 50))
                }
                .padding()
                .layoutPriority(1)
                
                Button(action: {
                    guard self.computerChoice != .Paper else { return }
                    self.buttonTapped(.Paper)
                }) {
                    Image(systemName: "doc.text").font(Font.system(size: 50))
                }
                .padding()
                .layoutPriority(1)
            }
            
        }
        .alert(isPresented: $theGameIsOverAlert) { () -> Alert in
            Alert(title: Text("The game is over!"), message: Text("Your score is \(self.scoreOfTheGame)"), dismissButton: .default(Text("Restart Game"), action: {
                // Restart game
                self.restartGame()
            }))
        }
    }
    
    
    
    
    // MARK: - Functions
    
    /// When a button is tapped, it checks if the player won
    func buttonTapped(_ playerOption: GameOptions) {
        // Just in case :)
        guard roundOfGame <= 10 else { return } // restart game
        computeScore(playerOption)
        nextRound()
    }
    
    
    /// Checks if player won and adds or removes points
    func computeScore(_ playerOption: GameOptions) {
        if didPlayerWon(player: playerOption, computer: self.computerChoice, playerShouldWin: playerShouldWin) {
            scoreOfTheGame += 1
        } else {
            if scoreOfTheGame > 0 {
                scoreOfTheGame -= 1
            }
        }
    }
    
    
    /// Changes the state for next round
    func nextRound() {
        // Adds to round of the game
        roundOfGame += 1
        // the computer makes an option
        computerChoice = GameOptions.allCases.randomElement()!
        // Random choose if player must win or loose
        playerShouldWin = Bool.random()
//
//        timer = Timer(timeInterval: TimeInterval(exactly: 3.0)!, repeats: false, block: { (innerTimer) in
//            print(innerTimer.timeInterval)
//        })
//        timer.fire()
        // If you are at round 10 the game is over
        if roundOfGame == 10 {
            theGameIsOverAlert = true
        }
    }
    
    
    
    /// Reset the state of the game
    func restartGame() {
        roundOfGame = 1
        scoreOfTheGame = 0
        playerShouldWin = Bool.random()
        computerChoice = GameOptions.allCases.randomElement()!
    }

    
}


/// Checks if player won, and return the result PURE
func didPlayerWon(player optionOfPlayer: GameOptions,computer optionOfComputer: GameOptions, playerShouldWin: Bool) -> Bool {
    switch (optionOfPlayer,optionOfComputer) {
    case (.Rock,.Scissors):
        return playerShouldWin ? true : false
    case (.Scissors,.Paper):
        return playerShouldWin ? true : false
    case (.Paper,.Rock):
        return playerShouldWin ? true : false
    default:
        return playerShouldWin ? false : true
    }
}


// MARK: Enum Game Options
enum GameOptions: String, CaseIterable {
    case Rock
    case Scissors
    case Paper
}




// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
