//
//  TransactionCell.swift
//  Split
//
//  Created by Brian Lee on 1/13/17.
//  Copyright © 2017 brianlee. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var transaction: Transaction! {
        didSet {
            let dic = transaction.toString()
            nameLabel.text = dic["name"]
            categoryLabel.text = dic["category"]
            amountLabel.text = dic["amount"]
            dateLabel.text = dic["date"]
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
