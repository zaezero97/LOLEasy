//
//  SummonerInfoUseCase.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/26.
//

import Foundation
import RxSwift
import SwiftUI

protocol SummonerInfoUseCase: AnyObject {
    func fetchSummoner(id: String) -> Observable<Result<Summoner,URLError>>
    func fetchLeagueEntry(id: String) -> Observable<Result<
        LeagueEntry,URLError>>
    func fetchRegisteredSummoner() -> String?
    func registerSummoner(name: String?)
}

final class DefaultSummonerInfoUseCase: SummonerInfoUseCase {
    
    private let summonerRepository: SummonerRepository
    
    init(summonerRepository: SummonerRepository) {
        self.summonerRepository = summonerRepository
    }
    
    func fetchSummoner(id: String) -> Observable<Result<Summoner,URLError>>{
        return self.summonerRepository.fetchSummoner(id: id)
    }
    
    func fetchLeagueEntry(id: String) -> Observable<Result<LeagueEntry,URLError>> {
        let a = self.summonerRepository.fetchLeagueEntry(id: id)
            .map{
                result -> Result<LeagueEntry, URLError> in
                switch result {
                case let .success(leagueEntrys):
                    return .success(leagueEntrys.first(where: {
                        $0.queueType == .RANKED_SOLO_5x5
                    })!)
                case let .failure(error):
                    return .failure(error)
                }
            }
        return a
    }
    
    func fetchRegisteredSummoner() -> String? {
        return self.summonerRepository.fetchRegisteredSummoner()
    }
    
    func registerSummoner(name: String?) {
        self.summonerRepository.registerSummoner(name: name)
    }
    
}
