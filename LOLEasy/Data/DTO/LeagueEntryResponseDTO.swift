//
//  LeagueEntryResponseDTO.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/26.
//

import Foundation

struct LeagueEntryResponseDTO: Decodable {
    let leagudId: String?
    let summonerId: String
    let summonerName: String
    let queueType: QueueType
    let tier: Tier?
    let rank: String?
    let leaguePoints: Int
    let wins: Int
    let losses: Int
    let veteran: Bool
    let inactive: Bool
    let freshBlood: Bool
    let hotStreak: Bool
    
    func toDomain() -> LeagueEntry {
        let domain = LeagueEntry(queueType: self.queueType, tier: self.tier, rank: self.rank, leaguePoints: self.leaguePoints, wins: self.wins, losses: self.losses)
        return domain
    }
}
