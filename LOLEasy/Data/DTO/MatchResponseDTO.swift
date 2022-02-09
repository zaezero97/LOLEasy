//
//  MatchResponseDTO.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/02/07.
//

import Foundation

struct MatchResponseDTO: Codable {
    let metadata: MetaDataResponseDTO
    let info: MatchInfoResponseDTO
}

struct MetaDataResponseDTO: Codable {
    let dataVersion: String
    let matchId: String
    let participants: [String]
    
    func toDomain() -> MetaData {
        return MetaData(
            dataVersion: self.dataVersion,
            matchId: self.matchId,
            participants: self.participants
        )
    }
}

struct MatchInfoResponseDTO: Codable {
    let gameCreation: Int
    let gameDuration: Int
    let gameEndTimestamp: Int
    let participants: [ParticipantResponseDTO]
    
    func toDomain() -> MatchInfo {
        return MatchInfo(
            gameCreation: self.gameCreation,
            gameDuration: self.gameDuration,
            gameEndTimestamp: self.gameEndTimestamp,
            participants: self.participants.map{$0.toDomain()}
        )
    }
}

struct ParticipantResponseDTO: Codable {
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
    let perks: PerkResponseDTO
    
    func toDomain() -> Participant {
        return Participant(
            assists: self.assists,
            championId: self.championId,
            championName: self.championName,
            deaths: self.deaths,
            kills: self.kills,
            item0: self.item0,
            item1: self.item1,
            item2: self.item2,
            item3: self.item3,
            item4: self.item4,
            item5: self.item5,
            item6: self.item6,
            summonerName: self.summonerName,
            summonerId: self.summonerId,
            perks: self.perks.toDomain()
        )
    }
}

struct PerkResponseDTO: Codable {
    let styles: [PerkStyleResponseDTO]
    
    func toDomain() -> Perk{
        return Perk(styles: self.styles.map { $0.toDomain() })
    }
}

struct PerkStyleResponseDTO: Codable {
    let description: String
    let selections: [PerkSelectionResponseDTO]
    let style: Int
    
    func toDomain() -> PerkStyle{
        return PerkStyle(
            description: PerkStyleType(rawValue: self.description) ?? .primaryStyle,
            selections: self.selections.map({ $0.toDomain() }),
            style: self.style
        )
    }
}

struct PerkSelectionResponseDTO: Codable {
    let perk: Int
    let var1: Int
    let var2: Int
    let var3: Int
    
    func toDomain() -> PerkSelection {
        return PerkSelection(
            perk: self.perk,
            var1: self.var1,
            var2: self.var2,
            var3: self.var3
        )
    }
}

extension MatchResponseDTO {
    func toDomain() -> Match {
        Match(metadata: self.metadata.toDomain(), info: self.info.toDomain())
    }
}
