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
    /// The remaining second to the next round
    @State private var remainingSeconds = 5
    
    let numberOfSecondsToNextRound = 5
    // MARK: - View
    var body: some View {
        
        VStack {
            // Game statistics Stack
            HStack {
                Text("Round: \(self.roundOfGame)/10")
                Text("Score: \(self.scoreOfTheGame)")
            }
            
            Text("Next round in: \(remainingSeconds) seconds")
            
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
        .onAppear {
            self.configureTimer()
        }
    }
    
    
    
    
    // MARK: - Functions
    
    //1
    /// When a button is tapped, it checks if the player won NOT PURE
    func buttonTapped(_ playerOption: GameOptions) {
        computeScore(playerWon: didPlayerWon(player: playerOption, computer: self.computerChoice, playerShouldWin: playerShouldWin))
        nextRound()
    }
    
    //1.2
    /// Checks if player won and adds or removes points NOT PURE
    func computeScore(playerWon: Bool) {
        if playerWon {//didPlayerWon(player: playerOption, computer: self.computerChoice, playerShouldWin: playerShouldWin) {
            scoreOfTheGame += 1
        } else {
            if scoreOfTheGame > 0 {
                scoreOfTheGame -= 1
            }
        }
    }
    
    //1.3
    /// Changes the state for next round NOT PURE
    func nextRound() {
        // Adds to round of the game
        roundOfGame += 1
        // the computer makes an option
        computerChoice = GameOptions.allCases.randomElement()!
        // Random choose if player must win or loose
        playerShouldWin = Bool.random()
        // the remaining seconds of the round
        remainingSeconds = numberOfSecondsToNextRound
        // If you are at round 10 the game is over
        if roundOfGame == 10 {
            theGameIsOverAlert = true
        }
    }
    
    
    //2
    /// Reset the state of the game NOT PURE
    func restartGame() {
        roundOfGame = 1
        scoreOfTheGame = 0
        remainingSeconds = numberOfSecondsToNextRound
        playerShouldWin = Bool.random()
        computerChoice = GameOptions.allCases.randomElement()!
    }

    //0
    // NOT PURE
    func configureTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (inTimer) in
            self.remainingSeconds -= 1
            if self.remainingSeconds == 0 {
                self.computeScore(playerWon: false)
                self.nextRound()
            }
        })
    }
    
    
}




//1.1
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
