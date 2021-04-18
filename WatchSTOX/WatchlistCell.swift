//
//  WatchlistCell.swift
//  WatchSTOX
//
//  Created by Emmanuel Sanchez on 4/17/21.
//

import UIKit

class WatchlistCell: UITableViewCell {

    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var tickerSymbol: UILabel!
    @IBOutlet weak var stockPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
