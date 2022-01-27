//
//  SummonerInfoUseCase.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/26.
//

import Foundation
import RxSwift

protocol SummonerInfoUseCase: AnyObject {
    func fetchSummoner(id: String) -> Observable<Result<Summoner,URLError>>
    func fetchLeagueEntry(id: String) -> Single<LeagueEntry>
}

final class DefaultSummonerInfoUseCase: SummonerInfoUseCase {
   
    private let summonerRepository: SummonerRepository
    
    init(summonerRepository: SummonerRepository) {
        self.summonerRepository = summonerRepository
    }
    
    func fetchSummoner(id: String) -> Observable<Result<Summoner,URLError>>{
        return self.summonerRepository.fetchSummoner(id: id)
    }
    
    func fetchLeagueEntry(id: String) -> Single<LeagueEntry> {
        return self.summonerRepository.fetchLeagueEntry(id: id)
            .map{ (leagueEntrys: [LeagueEntry]) -> LeagueEntry in
                return leagueEntrys.first { $0.queueType == .RANKED_SOLO_5x5 }!
            }
    }
}
