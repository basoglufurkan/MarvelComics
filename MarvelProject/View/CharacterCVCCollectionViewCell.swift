//
//  CharacterCVCCollectionViewCell.swift
//  MarvelProject
//
//  Created by Furkan Başoğlu on 4.09.2021.
//

import UIKit

class CharacterCVC: UICollectionViewCell {
    
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var characterImageView : UIImageView!
    @IBOutlet weak var favoriteImageView : UIImageView!
    @IBOutlet weak var characterName : UILabel!
    
    var indexPath: IndexPath? = nil
    private var favorited: Bool = false


    override func layoutSubviews() {
        characterImageView.layer.cornerRadius = 10
        characterImageView.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with model: CharacterCollectionVCModel?) {
        
        favorited = model?.favorited ?? false
        characterName.text = model?.title
        favoriteImageView.isHidden = !favorited
        
        guard let url = model?.imageURL else {
            return
        }
        
        characterImageView.setImgWebUrl(url: url, isIndicator: true)
     
    }
    
}

