//
//  ViewController.swift
//  TicTacToe
//
//  Created by Anthony Cianfrocco on 8/20/19.
//  Copyright © 2019 Anthony Cianfrocco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playerOneName: UITextField!
    @IBOutlet weak var playerTwoName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didGameBegin(_ sender: Any) {
        
        if playerNamesNotEmpty() {
            print("Transitioning to game board!")
            performSegue(withIdentifier: "HomeToGameBoard", sender: self)
        }
        else {
            print("Please enter both player's names")
        }
    }
    
    func playerNamesNotEmpty() -> Bool {
        var lbNamesNotEmpty = false
        if playerOneName.text != "" && playerTwoName.text != "" {
            lbNamesNotEmpty = true
        }
        
        return lbNamesNotEmpty
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? GameBoardVC
        destinationVC?.playerOneName = self.playerOneName.text ?? ""
        destinationVC?.playerTwoName = self.playerTwoName.text ?? ""
    }
}

