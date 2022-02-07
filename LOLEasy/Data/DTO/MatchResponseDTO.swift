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
    
    func toDomain() -> MatchInfo {
        return MatchInfo(
            gameCreation: self.gameCreation,
            gameDuration: self.gameDuration,
            gameEndTimestamp: self.gameEndTimestamp
        )
    }
}

extension MatchResponseDTO {
    func toDomain() -> Match {
        Match(metadata: self.metadata.toDomain(), info: self.info.toDomain())
    }
}
