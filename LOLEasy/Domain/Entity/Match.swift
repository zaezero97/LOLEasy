//
//  Match.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/02/07.
//

import Foundation

struct Match: Codable {
    let metadata: MetaData
    let info: MatchInfo
}

struct MetaData: Codable {
    let dataVersion: String
    let matchId: String
    let participants: [String]
}

struct MatchInfo: Codable {
    let gameCreation: Int
    let gameDuration: Int
    let gameEndTimestamp: Int
}
