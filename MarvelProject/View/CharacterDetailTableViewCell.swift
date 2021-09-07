//
//  CharacterDetailTableViewCell.swift
//  MarvelProject
//
//  Created by Furkan Başoğlu on 4.09.2021.
//

import UIKit

class CharacterDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var lblName : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
