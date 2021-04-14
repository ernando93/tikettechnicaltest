//
//  HeroesDetailsViewController.swift
//  Dota Hero
//
//  Created by Ernando Kasaluhe on 13/04/21.
//

import UIKit
import RxCocoa

class HeroesDetailsViewController: UIViewController {

    @IBOutlet weak var imageViewHero: UIImageView!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelAttribute: UILabel!
    @IBOutlet weak var labelHealth: UILabel!
    @IBOutlet weak var labelMaxAttack: UILabel!
    @IBOutlet weak var labelSpeed: UILabel!
    @IBOutlet weak var labelRoles: UILabel!
    @IBOutlet weak var collectionHeros: UICollectionView!

    var collectionHerosWidth: CGFloat = 0.0
    var heroes = BehaviorRelay<[HeroStats]>(value: [])
    var filterHeroes = BehaviorRelay<[HeroStats]>(value: [])
    var hero: HeroStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = hero?.localizedName
        overrideUserInterfaceStyle = .light
        imageViewHero.kf.indicatorType = .activity
        imageViewHero.kf.setImage(with: URL.init(string: "https://api.opendota.com\(hero?.img ?? "")"), placeholder: UIImage(named: "placeholderHero"), options: [], completionHandler: nil)
        labelType.text = "Attack Type: \(hero?.attackType ?? "")"
        labelAttribute.text = "STR: \(hero?.baseStr ?? 0), AGI: \(hero?.baseAgi ?? 0), INT: \(hero?.baseInt ?? 0)"
        labelHealth.text = "Health: \(hero?.baseHealth ?? 0)"
        labelMaxAttack.text = "Max Speed: \(hero?.baseAttackMax ?? 0)"
        labelSpeed.text = "Speed: \(hero?.moveSpeed ?? 0)"
        labelRoles.text = "Roles: \(hero?.roles.joined(separator: ", ") ?? "")"
        setupCollectionView()
        setupDataForCollectionView(with: hero?.primaryAttr ?? "")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionHerosWidth = collectionHeros.frame.size.width / 2
    }
    
    private func setupCollectionView() {
        collectionHeros.register(UINib(nibName: "HeroCell", bundle: nil), forCellWithReuseIdentifier: "heroCell")
        collectionHeros.dataSource = self
        collectionHeros.delegate = self
    }
    
    private func setupDataForCollectionView(with attr: String) {
        if attr == "agi" {
            filterHeroes.accept(Array(heroes.value.sorted(by: {$0.moveSpeed > $1.moveSpeed}).prefix(3)))
        } else if attr == "str" {
            filterHeroes.accept(Array(heroes.value.sorted(by: {$0.baseAttackMax > $1.baseAttackMax}).prefix(3)))
        } else if attr == "int" {
            filterHeroes.accept(Array(heroes.value.sorted(by: {$0.baseMana > $1.baseMana}).prefix(3)))
        }
        collectionHeros.reloadData()
    }
}

extension HeroesDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionHerosWidth - 10.0, height: collectionHerosWidth - 10.0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterHeroes.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as! HeroCell
        cell.configure(item: filterHeroes.value[indexPath.row])
        return cell
    }
}
