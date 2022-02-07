//
//  MatchUseCase.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/02/04.
//

import Foundation
import RxSwift
import RxCocoa

protocol MatchUseCase {
    func fetchMatchIds(puuid: String) -> Observable<[String]>
    func fetchMatch(matchId: String) -> Observable<Match>
}


final class DefaultMatchUseCase: MatchUseCase {
    private let summonerRepository: SummonerRepository
    
    init(summonerRepository: SummonerRepository) {
        self.summonerRepository = summonerRepository
    }
    
    func fetchMatchIds(puuid: String) -> Observable<[String]> {
        return self.summonerRepository.fetchMatchIds(puuid: puuid)
    }
    
    func fetchMatch(matchId: String) -> Observable<Match> {
        self.summonerRepository.fetchMatch(matchId: matchId)
    }
}
