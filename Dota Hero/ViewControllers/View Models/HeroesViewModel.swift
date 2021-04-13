//
//  HeroesViewModel.swift
//  Dota Hero
//
//  Created by Ernando Kasaluhe on 13/04/21.
//

import UIKit
import RxCocoa
import RxSwift
import Moya
import Moya_ModelMapper

class HeroesViewModel: NSObject {
    
    var roles:[String] = []
    var heroes = BehaviorRelay<[HeroStats]>(value: [])
    var filterHeroes = BehaviorRelay<[HeroStats]>(value: [])
    var disposeBag = DisposeBag()
    private let provider = MoyaProvider<HeroStatsAPI>()
    
    func fetchHeroes(completionHandler: @escaping(_ success: Bool?,_ error: String?) -> Void) {
        provider.rx.request(.heroes).filterSuccessfulStatusCodes().mapJSON().subscribe(onSuccess: { (response) in
            guard let jsonData = try? JSONSerialization.data(withJSONObject: response) else {return}
            do {
                let decoder = JSONDecoder()
                let res = try decoder.decode([HeroStats].self, from: jsonData)
                self.heroes.accept(res)
                self.filterHeroes.accept(res)
                var arrayRoles: [String] = ["All"]
                for data in res {
                    arrayRoles.append(contentsOf: data.roles)
                }
                self.roles = self.uniqueElementsFrom(array: arrayRoles)
                DispatchQueue.main.async {
                    completionHandler(true, nil)
                }
            } catch {
                print(error.localizedDescription)
            }
        }, onError: { (error) in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    func uniqueElementsFrom(array: [String]) -> [String] {
      var set = Set<String>()
      let result = array.filter {
        guard !set.contains($0) else {
          return false
        }
        set.insert($0)
        return true
      }
      return result
    }
}
