//
//  SummonerResponseDTO.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/26.
//

import Foundation

struct SummonerResponseDTO: Decodable {
    let accountId: String
    let profileIconId: Int
    let revisionDate: Int
    let name: String
    let id: String
    let puuid: String
    let summonerLevel: Int
 
    func toDomain() -> Summoner {
        let domain = Summoner(accountId: self.accountId, profileIconId: self.profileIconId, name: self.name, id: self.id, puuid: self.puuid, summonerLevel: self.summonerLevel)
        return domain
    }
    
}
