//
//  HeroStatsAPI.swift
//  Dota Hero
//
//  Created by Ernando Kasaluhe on 13/04/21.
//

import Foundation
import Moya

enum HeroStatsAPI: TargetType {
    case heroes
    
    public var baseURL: URL {
        return URL(string: "https://api.opendota.com/api/herostats")!
    }
    
    public var path: String {
        switch self {
        case .heroes:
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .heroes:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .heroes:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
}
