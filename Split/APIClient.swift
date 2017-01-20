//
//  APIClient.swift
//  Split
//
//  Created by Brian Lee on 1/12/17.
//  Copyright © 2017 brianlee. All rights reserved.
//

import Foundation
import AFNetworking

class APIClient {
    static let client_id = "5877952dbdc6a43ca37681df"
    static let public_key = "1474c9ea98cf1fcf1ea2f6629fa1ab"
    static let secret = "a41afe93871ee2d5818311a4bd5c8e"
    
    static let http = AFHTTPSessionManager()
    
    private class func parseTransactionJSON(data: Any) -> [Transaction] {
        let dic = data as! NSDictionary
        let accounts_dic = dic["accounts"] as! [NSDictionary]
        let transactions_dic = dic["transactions"] as! [NSDictionary]
        
        //creates a dictionary of account id's that map to account names
        var accounts = Dictionary<String, String>()
        for account in accounts_dic {
            let meta = account["meta"] as! NSDictionary
            let id = account["_id"] as! String
            let name = meta["name"] as! String
            
            accounts[id] = name
        }
        
        //create an array of transaction objects
        var transactions = [Transaction]()
        for transaction in transactions_dic {
            let t = Transaction(dictionary: transaction, accounts: accounts)
            transactions.append(t)
        }
        
        return transactions
    }
    
    class func getTransactions(accessToken: String, completion: @escaping (_ response: [Transaction]?, _ error: Error?) -> ()){
        
        let apiURL = "https://tartan.plaid.com/connect/get"
        let params = ["client_id" : client_id, "secret" : secret, "access_token" : accessToken]
        
        http.post(apiURL, parameters: params, progress: { (progress: Progress) -> Void in
            }, success: { (dataTask: URLSessionDataTask, response: Any?) -> Void in
                
                let transactions = parseTransactionJSON(data: response!)
                
                completion(transactions, nil)
                
                
        }) { (dataTask: URLSessionDataTask?, error: Error) -> Void in
            
            completion(nil, error)
        }
    }
    
    class func getAccessToken(username: String, password: String, bank: String, completion: @escaping (_ response: String?, _ error: Error?) -> ()){
        
        let apiURL = "https://tartan.plaid.com/connect"
        let params = ["client_id" : client_id, "secret" : secret, "username" : username, "password" : password, "type" : bank]
        
        http.post(apiURL, parameters: params, progress: { (progress: Progress) -> Void in
            }, success: { (dataTask: URLSessionDataTask, response: Any?) -> Void in
                
                let res = response as! NSDictionary
                let accessToken = res["access_token"] as! String
                
                completion(accessToken, nil)
                
                
        }) { (dataTask: URLSessionDataTask?, error: Error) -> Void in
            
            completion(nil, error)
        }
    }
}
