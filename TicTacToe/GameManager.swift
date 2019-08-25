//
//  GameManager.swift
//  TicTacToe
//
//  Created by Anthony Cianfrocco on 8/20/19.
//  Copyright © 2019 Anthony Cianfrocco. All rights reserved.
//

import Foundation
import UIKit

class GameManager{
    
    enum Turn {
        case empty
        case playerOne
        case playerTwo
    }
    
    var playerOneName:String
    var playerTwoName:String
    var currTurn:Turn
    var positions : [Turn]
    
    init () {
        self.playerOneName = ""
        self.playerTwoName = ""
        currTurn = Turn.empty
        positions = []
    }
    
    func startGame(playerOneName:String, playerTwoName:String) {
        print("Starting game")
        self.playerOneName = playerOneName
        self.playerTwoName = playerTwoName
        initalizePositions()
        currTurn = Turn.playerOne
    }
    
    func initalizePositions() {
        for _ in 0...8 {
            positions.append(Turn.empty)
        }
    }
    
    func changeTurn() {
        if self.currTurn == Turn.playerOne {
            self.currTurn = Turn.playerTwo
        }
        else {
            self.currTurn = Turn.playerOne
        }
    }
    
    func getTurn() -> Turn {
        return self.currTurn
    }
    
    func recordTurn(positionIdx:Int) {
        positions[positionIdx - 1] = currTurn
    }
    
    func checkOver() -> Bool {
        var lbGameOver = false // game is not over
        let lanStartIdx = [0, 3, 6]
        /// CHECK ROWS
        
        // check first row
        var lePrev = positions[0]
        var lbTemp = false
        for lnI in 1...2 {
            if positions[lnI] == lePrev {
                lbTemp = true
            }
            else {
                lbTemp = false
                break
            }
        }
        if lbTemp {
            return lbTemp
        }
        // check second row
        lePrev = positions[3]
        for lnI in 4...5 {
            if positions[lnI] == lePrev {
                lbTemp = true
            }
            else {
                lbTemp = false
                break
            }
        }
        if lbTemp {
            return lbTemp
        }
        // check third row
        lePrev = positions[3]
        for lnI in 4...5 {
            if positions[lnI] == lePrev {
                lbTemp = true
            }
            else {
                lbTemp = false
                break
            }
        }
        if lbTemp {
            return lbTemp
        }
        
        lbGameOver = lbTemp

        return lbGameOver
    }
}
