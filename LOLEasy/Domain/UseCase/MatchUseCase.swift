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
    func fetchMatchIds(puuid: String)
}


final class DefaultMatchUseCase: MatchUseCase {
    private let summonerRepository: SummonerRepository
    
    init(summonerRepository: SummonerRepository) {
        self.summonerRepository = summonerRepository
    }
    func fetchMatchIds(puuid: String) {
        self.summonerRepository.fetchMatchIds(puuid: puuid)
    }
}
