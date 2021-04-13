//
//  HeroesViewModel.swift
//  Dota Hero
//
//  Created by Ernando Kasaluhe on 13/04/21.
//

import UIKit

class HeroesViewModel: NSObject {
    
}

extension HeroesViewModel: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rolesCell", for: indexPath) as! RolesCell
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as! HeroCell
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
