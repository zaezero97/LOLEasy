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
    func fetchLeagueEntry(id: String) -> Observable<Result<
        [LeagueEntry],URLError>>
    func fetchRegisteredSummoner() -> String?
    func registerSummoner(name: String?)
    func unRegisterSummoner()
    func fetchMatchIds(puuid: String)  -> Observable<[String]>
}


