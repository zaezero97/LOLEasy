//
//  RiotAPIProvider.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/02/07.
//

import Foundation
import Moya

enum RiotAPIType {
    case getMatchV5ids(puuid: String)
}

extension RiotAPIType: TargetType {
    var baseURL: URL {
        return URL(string: "https://asia.api.riotgames.com/lol/match/v5/matches/by-puuid")!
    }
    
    var path: String {
        switch self {
        case .getMatchV5ids(let puuid):
            return "/\(puuid)/ids"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case . getMatchV5ids(_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getMatchV5ids(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "X-Riot-Token": APP.RiotToken
        ]
    }
    
    
}
