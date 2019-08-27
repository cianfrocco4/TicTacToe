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
    var winner:String
    var loser:String
    var currTurn:Turn
    var positions : [Turn]
    
    init () {
        self.playerOneName = ""
        self.playerTwoName = ""
        winner = ""
        loser = ""
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
    
    func checkOver(anIndex:Int) -> Bool {
        // anIndex - 1 is used to switch to 0-indexing used in swift
        let lnRowStartIdx = getRowStartIdx(anIndex: anIndex - 1)
        let lbRowCheck = checkRow(anStartIdx: lnRowStartIdx)
        let lnColStartIdx = getColStartIdx(anIndex: anIndex - 1)
        let lbColCheck = checkCol(anStartIdx: lnColStartIdx)
        let lbDiagCheck = checkDiagonals(anIndex: anIndex - 1)
        
        var lbGameOver = false
        
        if lbRowCheck || lbColCheck || lbDiagCheck {
            lbGameOver = true
            if currTurn == Turn.playerOne {
                winner = playerOneName
                loser = playerTwoName
            }
            else {
                winner = playerTwoName
                loser = playerOneName
            }
            
        }
        else if checkBoardFull() {
            lbGameOver = true
            // winner stays empty since no one one
        }
        
        return lbGameOver
    }
    
    func getRowStartIdx(anIndex:Int) -> Int{
        if anIndex < 3 {
            return 0
        }
        else if anIndex < 6 {
            return 3
        }
        else if anIndex < 9 {
            return 6
        }
        else {
            print("Invalid Index")
            return -1
        }
    }
    
    func getColStartIdx(anIndex:Int) -> Int{
        if anIndex % 3 == 0{
            return 0
        }
        else if anIndex % 3 == 1 {
            return 1
        }
        else if anIndex % 3 == 2 {
            return 2
        }
        else {
            print("Invalid Index")
            return -1
        }
    }
    
    func checkRow(anStartIdx:Int) -> Bool {
        var lbRowCheck = false
        let lePrev = positions[anStartIdx]
        if lePrev != Turn.empty {
            if (positions[anStartIdx+1] == lePrev) && (positions[anStartIdx+2] == lePrev) {
                lbRowCheck = true
            }
        }
        return lbRowCheck
    }
    
    func checkCol(anStartIdx:Int) -> Bool {
        var lbColCheck = false
        let lePrev = positions[anStartIdx]
        if lePrev != Turn.empty {
            if positions[anStartIdx+3] == lePrev && positions[anStartIdx+6] == lePrev {
                lbColCheck = true
            }
        }
        return lbColCheck
    }
    func checkBoardFull() -> Bool {
        // assume true from start
        var lbFull = true
        for lnI in 0...positions.count - 1 {
            // if atleast one spot is empty then return false
            if positions[lnI] == Turn.empty{
                lbFull = false
                break
            }
        }
        return lbFull
    }
    
    func checkDiagonals(anIndex:Int) -> Bool {
        let lanNonDiagIdx = [1, 3, 5, 7]
        let lanRightToLeftDiagIdx = [2, 4, 6]
        let lanLeftToRightDiagIdx = [0, 4, 8]
        
        var lbCheckDiags = false
        
        if lanNonDiagIdx.contains(anIndex) {
            // diagonal does not need to be checked for this position
            lbCheckDiags =  false
        }
        else {
            var lbRToL = false
            var lbLToR = false
            if lanRightToLeftDiagIdx.contains(anIndex) {
                // check Upper right to lower left diagonal
                lbRToL = checkRightToLeftDiag()
            }
            if lanLeftToRightDiagIdx.contains(anIndex){
                // check Upper left to lower right diagonal
                lbLToR = checkLeftToRightDiag()
            }
            if lbRToL || lbLToR {
                lbCheckDiags = true
            }
        }
        return lbCheckDiags
    }
    
    func checkRightToLeftDiag() -> Bool {
        var lbCheck = false
        let lePrev = positions[2]
        if positions[4] == lePrev && positions[6] == lePrev {
            lbCheck = true
        }
        return lbCheck
    }
    
    func checkLeftToRightDiag() -> Bool {
        var lbCheck = false
        let lePrev = positions[0]
        if positions[4] == lePrev && positions[8] == lePrev {
            lbCheck = true
        }
        return lbCheck
    }

}
