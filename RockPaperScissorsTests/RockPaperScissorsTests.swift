//
//  RockPaperScissorsTests.swift
//  RockPaperScissorsTests
//
//  Created by NICK POLYCHRONAKIS on 18/10/19.
//  Copyright © 2019 NICK POLYCHRONAKIS. All rights reserved.
//

import XCTest
@testable import RockPaperScissors

class RockPaperScissorsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Testing if game works as expected
    func testLogicOfGame() {
        var playerWon = didPlayerWon(player: .Paper, computer: .Rock, playerShouldWin: true)
        XCTAssert(playerWon == true)
        
        playerWon = didPlayerWon(player: .Rock, computer: .Scissors, playerShouldWin: true)
        XCTAssert(playerWon == true)
        
        playerWon = didPlayerWon(player: .Scissors, computer: .Rock, playerShouldWin: true)
        XCTAssert(playerWon == false)
        
        
        playerWon = didPlayerWon(player: .Paper, computer: .Rock, playerShouldWin: false)
        XCTAssert(playerWon == false)
        
        playerWon = didPlayerWon(player: .Rock, computer: .Scissors, playerShouldWin: false)
        XCTAssert(playerWon == false)
        
        playerWon = didPlayerWon(player: .Scissors, computer: .Rock, playerShouldWin: false)
        XCTAssert(playerWon == true)
        

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
