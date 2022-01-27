//
//  RiotAPI.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/27.
//

import Foundation

struct RiotAPI {
    static let scheme = "https"
    static let host = "kr.api.riotgames.com"
    static let summmonerV4 = "/lol/summoner/v4/summoners/by-name/"
    
    func getSummonerV4URL(id: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = RiotAPI.scheme
        components.host = RiotAPI.host
        components.path = RiotAPI.summmonerV4 + id
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: App.RiotToken)
        ]
        
        print(components)
        return components
    }
}
