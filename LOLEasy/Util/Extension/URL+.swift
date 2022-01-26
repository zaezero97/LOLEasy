//
//  URL+.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/26.
//

import Foundation

extension URL {
    static func SUMMONER_V4(id: String) -> String {
        return "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/\(id)"
    }
}
