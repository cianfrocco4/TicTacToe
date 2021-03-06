//
//  GameBoardVC.swift
//  TicTacToe
//
//  Created by Anthony Cianfrocco on 8/21/19.
//  Copyright © 2019 Anthony Cianfrocco. All rights reserved.
//

import UIKit

class GameBoardVC: UIViewController {
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var buttonFive: UIButton!
    @IBOutlet weak var buttonSix: UIButton!
    @IBOutlet weak var buttonSeven: UIButton!
    @IBOutlet weak var buttonEight: UIButton!
    @IBOutlet weak var buttonNine: UIButton!
    
    let gameManager = GameManager()
    
    let playerOneSymbol = "X"
    let playerTwoSymbol = "O"

    var playerOneName = ""
    var playerTwoName = ""
    @IBOutlet weak var gameLabel: UILabel!
    
    @IBOutlet weak var gameMessageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        gameLabel?.text = "\(playerOneName) versus \(playerTwoName)"
        gameLabel.sizeToFit()
        gameMessageLabel.text = "\(playerOneName) make a move!"
        gameManager.startGame(playerOneName: playerOneName, playerTwoName: playerTwoName)
        // Do any additional setup after loading the view.
        print("GameBoard view is loaded")
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }

        processButton(button: button)
        gameManager.recordTurn(positionIdx: button.tag)
        if gameManager.checkOver(anIndex: button.tag) {
            print("Game is over.")
            // winner must be the current player
            let lsWinner = gameManager.getTurn()
            print("Winner is \(lsWinner)!!")
            // segue to the end game screen now that the game is over
            performSegue(withIdentifier: "GameBoardToEndGame", sender: self)
            return
        }
        gameManager.changeTurn()
        if gameManager.getTurn() == GameManager.Turn.playerOne {
            self.gameMessageLabel.text = "\(playerOneName) make a move!"
        }
        else {
            self.gameMessageLabel.text = "\(playerTwoName) make a move!"
        }
    }
    
    func processButton(button:UIButton) {
        if gameManager.getTurn() == GameManager.Turn.playerOne {
            button.setTitle(playerOneSymbol, for: .normal)
        }
        else {
            button.setTitle(playerTwoSymbol, for: .normal)
        }
        button.setTitleColor(UIColor.white, for: .normal)
        button.isEnabled = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? GameOverVC
        destinationVC?.msWinner = gameManager.winner
        destinationVC?.msLoser = gameManager.loser
        destinationVC?.gameManager = self.gameManager
    }
}
