//
//  HeroStatsAPI.swift
//  Dota Hero
//
//  Created by Ernando Kasaluhe on 13/04/21.
//

import Foundation
import Moya

enum HeroStatsAPI: TargetType {
    case heros
    
    public var baseURL: URL {
        return URL(string: "https://api.opendota.com/api/herostats")!
    }
    
    public var path: String {
        switch self {
        case .heros:
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .heros:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .heros:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
}
