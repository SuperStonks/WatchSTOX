//
//  SearchCell.swift
//  WatchSTOX
//
//  Created by Mike Neri on 5/18/21.
//


import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var tickerSymbol: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
