//
//  Transaction.swift
//  Split
//
//  Created by Brian Lee on 1/12/17.
//  Copyright © 2017 brianlee. All rights reserved.
//

import Foundation

class Transaction: NSObject {
    let account_id: String?
    let account_name: String?
    let id: String?
    let amount: Double?
    let date: NSDate?
    let name: String?
    let pending: Bool?
    let category: [String]?
    
    init(dictionary: NSDictionary, accounts: Dictionary<String, String>){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.account_id = dictionary["_account"] as? String
        self.account_name = accounts[self.account_id!]
        self.id = dictionary["_id"] as? String
        self.amount = (dictionary["amount"] as! NSNumber).doubleValue
        self.date = dateFormatter.date(from: dictionary["date"] as! String) as NSDate?
        self.name = dictionary["name"] as? String
        self.pending = ("true" == dictionary["pending"] as? String)
        self.category = dictionary["category"] as? [String]
    }
    
    func printDetails() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var categories = String()
        if category != nil {
            for c in self.category! {
                categories += c
                categories += ", "
            }
            
            //removes extra space and comma at the end of categories
            categories.remove(at: categories.index(before: categories.endIndex))
            categories.remove(at: categories.index(before: categories.endIndex))
        } else {
            categories = "None"
        }
        
        print("Name: " + self.name!)
        print("Date: " + dateFormatter.string(from: self.date! as Date))
        print("Account: " + self.account_name!)
        print("Pending: " + self.pending!.description)
        print("Amount: $" + String(format:"%.2f", self.amount!))
        print("Categories: " + categories)
    }
    
    func toString() -> Dictionary<String, String> {
        var dic = Dictionary<String, String>()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        var categories = String()
        if category != nil {
            for c in self.category! {
                categories += c
                categories += ", "
            }
            
            //removes extra space and comma at the end of categories
            categories.remove(at: categories.index(before: categories.endIndex))
            categories.remove(at: categories.index(before: categories.endIndex))
        } else {
            categories = "None"
        }
        
        dic["category"] = categories
        dic["date"] = dateFormatter.string(from: self.date! as Date)
        dic["amount"] = "$" + String(format:"%.2f", self.amount!)
        dic["pending"] = self.pending!.description
        dic["name"] = self.name!
        dic["account"] = self.account_name!
        
        return dic
    }
    
}
