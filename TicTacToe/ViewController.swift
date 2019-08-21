//
//  ViewController.swift
//  TicTacToe
//
//  Created by Anthony Cianfrocco on 8/20/19.
//  Copyright © 2019 Anthony Cianfrocco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var playerOneName: UITextField!
    
    @IBOutlet weak var playerTwoName: UITextField!
    @IBAction func didGameBegin(_ sender: Any) {
        // Check that both players have entered their names
        if playerOneName.text != "" && playerTwoName.text != "" {
            performSegue(withIdentifier: "HomeToGameBoard", sender: self)
        }
        else {
            print("Please enter both player names before beginning")
        }
    }
}

