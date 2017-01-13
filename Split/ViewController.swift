//
//  ViewController.swift
//  Split
//
//  Created by Brian Lee on 1/12/17.
//  Copyright © 2017 brianlee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APIClient.getTransactions(username: "brianlxlee", password: "jpgphoto1", bank: "bofa") { (response, error) in
            if response == nil {
                print("failed to retrieve transactions")
            } else {
                for transaction in response! {
                    transaction.printDetails()
                    print()
                }
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

