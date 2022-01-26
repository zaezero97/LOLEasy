//
//  SummonerInfoUseCase.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/26.
//

import Foundation
import RxSwift

protocol SummonerInfoUseCase: AnyObject {
    func fetchSummoner(id: String) -> Single<Summoner>
}

final class DefaultSummonerInfoUseCase: SummonerInfoUseCase {
    private let summonerRepository: SummonerRepository
    
    init(summonerRepository: SummonerRepository) {
        self.summonerRepository = summonerRepository
    }
    
    func fetchSummoner(id: String) -> Single<Summoner> {
        return self.summonerRepository.fetchSummoner(id: id)
    }
}
