//
//  ViewController.swift
//  Split
//
//  Created by Brian Lee on 1/12/17.
//  Copyright © 2017 brianlee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var bankTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(_ sender: AnyObject) {
        let username = usernameTextfield.text!
        let password = passwordTextField.text!
        let bank = bankTextfield.text!
        
        APIClient.getTransactions(username: username, password: password, bank: bank) { (response, error) in
            if response == nil {
                print("failed to retrieve transactions")
            } else {
                for transaction in response! {
                    transaction.printDetails()
                    print()
                }
            }
        }
    }


}

