//
//  SummonerRepository.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/26.
//

import Foundation
import RxSwift

protocol SummonerRepository {
    func fetchSummoner(id: String) -> Observable<Result<Summoner,URLError>>
//    func registerSummoner(summoner: Summoner)
//    func fetchSummonerIcon(iconId: Int) -> Single<Data>
    func fetchLeagueEntry(id: String) -> Single<[LeagueEntry]>
//    func fetchLocalSavedSummonerName() -> Single<String>
//    func unregisterSummoner()
}


