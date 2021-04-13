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
        self.navigationItem.title = "All"
        overrideUserInterfaceStyle = .light
        collectionRoles.tag = 0
        collectionHeros.tag = 1
        setupCollectionView(in: collectionRoles)
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
        collectionView.dataSource = self
        collectionView.delegate = self
        viewModel.fetchHeroes(completionHandler: { (success, error) in
            collectionView.reloadData()
        })
    }
}

extension HeroesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    }
    
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return viewModel.roles.count
        case 1:
            return viewModel.filterHeroes.value.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rolesCell", for: indexPath) as! RolesCell
            cell.configure(roles: viewModel.roles[indexPath.row])
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as! HeroCell
            cell.configure(item: viewModel.filterHeroes.value[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 0:
            viewModel.filterHeroes.accept([])
            self.navigationItem.title = viewModel.roles[indexPath.row]
            if viewModel.roles[indexPath.row] == "All" {
                viewModel.filterHeroes.accept(viewModel.heroes.value)
            } else {
                for data in viewModel.heroes.value {
                    if data.roles.contains(viewModel.roles[indexPath.row]) {
                        viewModel.filterHeroes.accept(viewModel.filterHeroes.value + [data])
                    }
                }
            }
            collectionHeros.reloadData()
        case 1:
            let vc = HeroesDetailsViewController(nibName: "HeroesDetailsViewController", bundle: nil)
            vc.hero = viewModel.filterHeroes.value[indexPath.row]
            for data in viewModel.filterHeroes.value {
                if data.primaryAttr.contains(viewModel.filterHeroes.value[indexPath.row].primaryAttr) {
                    vc.heroes.accept(vc.heroes.value + [data])
                }
            }
            self.navigationController?.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
}
