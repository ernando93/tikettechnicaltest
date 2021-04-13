//
//  HeroesViewController.swift
//  Dota Hero
//
//  Created by Ernando Kasaluhe on 13/04/21.
//

import UIKit

class HeroesViewController: UIViewController {

    @IBOutlet weak var collectionRoles: UICollectionView!
    @IBOutlet weak var collectionHeros: UICollectionView!
    
    var collectionHerosWidth: CGFloat = 0.0
    var viewModel = HeroesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        collectionRoles.tag = 0
        setupCollectionView(in: collectionRoles)
        collectionHeros.tag = 1
        setupCollectionView(in: collectionHeros)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionHerosWidth = collectionHeros.frame.size.width / 2
    }
    
    private func setupCollectionView(in collectionView: UICollectionView) {
        switch collectionView.tag {
        case 0:
            collectionView.register(UINib(nibName: "RolesCell", bundle: nil), forCellWithReuseIdentifier: "rolesCell")
        case 1:
            collectionView.register(UINib(nibName: "HeroCell", bundle: nil), forCellWithReuseIdentifier: "heroCell")
        default:
            return
        }
        collectionView.dataSource = viewModel
        collectionView.delegate = self
    }
}

extension HeroesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            return CGSize(width: collectionRoles.frame.width, height: 50.0)
        case 1:
            return CGSize(width: collectionHerosWidth - 10.0, height: collectionHerosWidth - 10.0)
        default:
            return CGSize(width: 0.0, height: 0.0)
        }
    }
}
