//
//  DefaulutSummonerRepository.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/26.
//

import Foundation
import RxSwift

final class DefaultSummonerRepository: SummonerRepository {
    private let riotAPIDataSource: RiotAPIDataSource
    private let localDataSource: UserDefaultManager
    
    init(riotAPIDataSource: RiotAPIDataSource, localDataSource: UserDefaultManager = UserDefaultManager()) {
        self.riotAPIDataSource = riotAPIDataSource
        self.localDataSource = localDataSource
    }
    
    func fetchSummoner(id: String) -> Observable<Result<Summoner,URLError>> {
        return  self.riotAPIDataSource.fetchSummoner(id: id).compactMap { result in
            switch result {
            case .success(let summonerResponseDTO):
                return .success(summonerResponseDTO.toDomain())
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    func fetchLeagueEntry(id: String) -> Observable<Result<
        [LeagueEntry],URLError>> {
        self.riotAPIDataSource.fetchLeagueEntry(id: id)
            .map{
                result in
                switch result {
                case .success(let leagueEntryResponseDTOs):
                    return .success(leagueEntryResponseDTOs.map({
                        $0.toDomain()
                    }))
                case .failure(let error):
                    return .failure(error)
                }
            
            }
    }
    
    func fetchRegisteredSummoner() -> String? {
        return self.localDataSource.registeredSummoner
    }
    func registerSummoner(name: String?) {
        return self.localDataSource.registeredSummoner = name
    }
    
    func unRegisterSummoner() {
        self.localDataSource.unRegisterSummoner()
    }
    
    func fetchMatchIds(puuid: String) {
        return self.riotAPIDataSource.fetchMatchIds(puuid: puuid)
    }
}
