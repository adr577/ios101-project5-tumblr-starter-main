//
//  TableViewCell.swift
//  ios101-project5-tumblr
//
//  Created by Adrian Hernandez on 3/25/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageLabel: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        overviewLabel.numberOfLines = 4
        overviewLabel.lineBreakMode = .byWordWrapping // Wrap text by word
        posterImageLabel.contentMode = .scaleAspectFill

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
       
    }

}
