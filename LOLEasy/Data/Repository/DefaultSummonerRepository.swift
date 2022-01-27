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
    
    init(riotAPIDataSource: RiotAPIDataSource) {
        self.riotAPIDataSource = riotAPIDataSource
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
    
    func fetchLeagueEntry(id: String) -> Single<[LeagueEntry]> {
        self.riotAPIDataSource.fetchLeagueEntry(id: id)
            .map{ $0.map { $0.toDomain() } }
    }
}
