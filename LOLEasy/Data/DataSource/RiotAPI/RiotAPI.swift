//
//  RiotAPI.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/27.
//

import Foundation

struct RiotAPI {
    private let scheme = "https"
    private let host = "kr.api.riotgames.com"
    private let summmonerV4 = "/lol/summoner/v4/summoners/by-name/"
    private let LeagueV4 = "/lol/league/v4/entries/by-summoner/"
    
    func getSummonerV4URL(id: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.summmonerV4 + id
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: APP.RiotToken)
        ]
        
        print(components)
        return components
    }
    
    func getLeagueV4URL(id: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.LeagueV4 + id
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: APP.RiotToken)
        ]
        
        print(components)
        return components
    }
}
