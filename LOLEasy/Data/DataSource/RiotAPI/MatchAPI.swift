//
//  RiotAPIProvider.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/02/07.
//

import Foundation
import Moya

enum MatchAPI {
    case getMatchV5ids(puuid: String)
    case getMatch(matchId: String)
}

extension MatchAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://asia.api.riotgames.com/lol/match/v5/matches")!
    }
    
    var path: String {
        switch self {
        case .getMatchV5ids(let puuid):
            return "/by-puuid/\(puuid)/ids"
        case .getMatch(let matchId):
            return "/\(matchId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMatchV5ids(_):
            return .get
        case .getMatch(_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getMatchV5ids(_):
            return .requestPlain
        case .getMatch(_):
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
