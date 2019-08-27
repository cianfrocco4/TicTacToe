//
//  GameOverVC.swift
//  TicTacToe
//
//  Created by Anthony Cianfrocco on 8/25/19.
//  Copyright © 2019 Anthony Cianfrocco. All rights reserved.
//

import UIKit

class GameOverVC: UIViewController {

    @IBOutlet weak var gameOverLabel: UILabel!
    
    var msWinner = ""
    var msLoser = ""
    var gameManager = GameManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var lsLabelText = ""
        if msWinner == "" {
            lsLabelText = "Draw!"
            self.msWinner = gameManager.playerOneName
            self.msLoser = gameManager.playerTwoName
        }
        else {
            lsLabelText = "\(msWinner) wins!!!\n\(msWinner) beat \(msLoser)"
        }
        gameOverLabel.text = lsLabelText
        gameOverLabel.sizeToFit()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        performSegue(withIdentifier: "EndToGameBoard", sender: self)
    }
    
    @IBAction func exitPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "EndToHome", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "EndToGameBoard":
            let destinationVC = segue.destination as? GameBoardVC
            if gameManager.getTurn() == GameManager.Turn.playerOne {
                destinationVC?.playerOneName = self.msLoser
                destinationVC?.playerTwoName = self.msWinner
            }
            else if gameManager.getTurn() == GameManager.Turn.playerTwo {
                destinationVC?.playerOneName = self.msWinner
                destinationVC?.playerTwoName = self.msLoser
            }
            else {
                print("Error: GameManager not set correctly")
            }
        default:
            print("No preparation needed for this segue")
        }
    }
}
