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
    let participants: [Participant]
}

struct Participant: Codable {
    let assists: Int
    let championId: Int
    let championName: String
    let deaths: Int
    let kills: Int
    let item0: Int
    let item1: Int
    let item2: Int
    let item3: Int
    let item4: Int
    let item5: Int
    let item6: Int
    let summonerName: String
    let summonerId: String
    let perks: Perk
    
    func toItemArray() -> [Int] {
        return [
            item0,
            item1,
            item2,
            item3,
            item4,
            item5,
            item6
        ]
    }
}

struct Perk: Codable {
    let styles: [PerkStyle]
}

enum PerkStyleType: String, Codable {
    case primaryStyle
    case subStyle
}

struct PerkStyle: Codable {
    let description: PerkStyleType
    let selections: [PerkSelection]
    let style: Int
}

struct PerkSelection: Codable {
    let perk: Int
    let var1: Int
    let var2: Int
    let var3: Int
}
