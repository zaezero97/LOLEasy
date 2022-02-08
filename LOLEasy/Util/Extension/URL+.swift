//
//  URL+.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/26.
//

import Foundation

extension URL {
    static func SUMMONER_V4(id: String) -> URLComponents? {
        return URLComponents(string: "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/\(id)")
    }
//    static func summonerIconURL(iconId: Int) -> String {
//        return "https://ddragon.leagueoflegends.com/cdn/10.11.1/img/profileicon/\(iconId).png"
//    }
    static func LEAGUE_V4(id: String) -> String {
        return "https://kr.api.riotgames.com/lol/league/v4/entries/by-summoner/\(id)"
    }
    
    static func profileIconURL(id: Int) -> URL {
        return URL(string: "https://ddragon.leagueoflegends.com/cdn/12.3.1/img/profileicon/\(id).png")!
    }
}
