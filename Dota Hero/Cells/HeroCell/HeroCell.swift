//
//  HeroCell.swift
//  Dota Hero
//
//  Created by Ernando Kasaluhe on 13/04/21.
//

import UIKit
import Kingfisher

class HeroCell: UICollectionViewCell {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageViewHero: UIImageView!
    @IBOutlet weak var labelHeroName: UILabel!
    
    func configure(item: HeroStats) {
        viewContainer.layer.cornerRadius = 3.0
        viewContainer.clipsToBounds = true
        imageViewHero.kf.indicatorType = .activity
        imageViewHero.kf.setImage(with: URL.init(string: "https://api.opendota.com\(item.img)"), placeholder: UIImage(named: "placeholderHero"), options: [], completionHandler: nil)
        labelHeroName.text = item.localizedName
    }
}
