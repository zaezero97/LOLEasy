//
//  SummonerRecordViewModel.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/02/04.
//

import Foundation
import RxSwift
import RxCocoa

final class SummonerRecordViewModel: ViewModelType {
    struct Input {
        //String: name
        let viewDidLoad: Observable<String>
    }
    struct Output{
        let summonerInfo: Driver<(Summoner,LeagueEntry)>
    }
    
    private let matchUseCase: MatchUseCase
    private let summonerInfoUseCase: SummonerInfoUseCase
    
    init(matchUseCase: MatchUseCase, summonerInfoUseCase: SummonerInfoUseCase) {
        self.matchUseCase = matchUseCase
        self.summonerInfoUseCase = summonerInfoUseCase
    }
    
    func transform(from input: Input) -> Output {
        
        let fetchSummonerResult = input.viewDidLoad
            .do(onNext: {
                print($0)
            })
            .flatMap(self.summonerInfoUseCase.fetchSummoner(id:))
            
        let fetchSummoner = fetchSummonerResult.compactMap { result -> Summoner? in
            guard case let .success(summoner) = result else { return nil }
            print("summoner", summoner)
            return summoner
        }
        
        
        let fetchLeagueEntry = fetchSummonerResult.compactMap {
            [weak self] result -> Observable<Result<LeagueEntry,URLError>>? in
            guard case let .success(summoner) = result else { return nil }
            return self?.summonerInfoUseCase.fetchLeagueEntry(id: summoner.id)
        }.flatMap{ $0 }
            .compactMap { result -> LeagueEntry? in
                guard case let .success(leagueEntry) = result else { return nil }
                print("leagueEntry", leagueEntry)
                return leagueEntry
            }
        
        
        
        
        return Output(
            summonerInfo: Observable.zip(fetchSummoner,fetchLeagueEntry).asDriver(onErrorDriveWith: Driver.empty())
        )
    }
}
