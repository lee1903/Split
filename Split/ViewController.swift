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
        let defaults = UserDefaults.standard
        let accessToken = defaults.object(forKey: "access_token")
        if accessToken != nil {
            self.transitionToTransactions(accessToken: accessToken as! String)
        }
        
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
        
        APIClient.getAccessToken(username: username, password: password, bank: bank) { (response, error) in
            if response == nil {
                print("failed to retrieve access token")
            } else {
                let defaults = UserDefaults.standard
                defaults.set(response!, forKey: "access_token")
                defaults.synchronize()
                
                self.transitionToTransactions(accessToken: response!)
            }
        }
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TransactionSegue" {
            let viewController = segue.destination as! TransactionViewController
            let transactions = sender as! [Transaction]
            viewController.transactions = transactions
        }
     }
    
    func transitionToTransactions(accessToken: String) {
        print(accessToken)
        APIClient.getTransactions(accessToken: accessToken) { (response, error) in
            if response == nil {
                print("failed to retrieve transactions")
            } else {
                for transaction in response! {
                    transaction.printDetails()
                    print()
                }
                self.performSegue(withIdentifier: "TransactionSegue", sender: response!)
            }
        }
    }
 

}

