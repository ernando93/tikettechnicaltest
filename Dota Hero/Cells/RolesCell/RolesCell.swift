//
//  RolesCell.swift
//  Dota Hero
//
//  Created by Ernando Kasaluhe on 13/04/21.
//

import UIKit

class RolesCell: UICollectionViewCell {

    @IBOutlet weak var buttonRoles: UIButton!
    
    func configure(roles: String) {
        buttonRoles.isUserInteractionEnabled = false
        buttonRoles.layer.cornerRadius = 8.0
        buttonRoles.setTitle(roles, for: .normal)
    }
}
