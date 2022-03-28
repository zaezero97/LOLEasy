//
//  LeagueEntry.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/26.
//

import Foundation

enum QueueType: String, Decodable {
    case RANKED_TFT_PAIRS
    case RANKED_SOLO_5x5
    case RANKED_TEAM_5x5
    case RANKED_FLEX_SR
}

struct LeagueEntry {
    let queueType: String
    let tier: Tier?
    let rank: String?
    let leaguePoints: Int
    let wins: Int
    let losses: Int
}
