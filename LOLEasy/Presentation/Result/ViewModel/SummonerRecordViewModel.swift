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
        let matches: Driver<Match>
        let myRecord: Driver<[Participant]>
    }
    
    private let matchUseCase: MatchUseCase
    private let summonerInfoUseCase: SummonerInfoUseCase
    
    init(matchUseCase: MatchUseCase, summonerInfoUseCase: SummonerInfoUseCase) {
        self.matchUseCase = matchUseCase
        self.summonerInfoUseCase = summonerInfoUseCase
    }
    
    func transform(from input: Input) -> Output {
        
        let fetchSummonerResult = input.viewDidLoad
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
        
        let matchIds = fetchSummoner.flatMap {
            [weak self] summoner -> Observable<[String]> in
            guard let self = self else { return .empty() }
            return self.matchUseCase.fetchMatchIds(puuid: summoner.puuid)
        }
        
        let matches = matchIds.flatMap { Observable.from($0) }
            .do(onNext: {
                print("id!!!!",$0)
            })
            .concatMap { [weak self] id -> Observable<Match>in
                guard let self = self else { return .empty() }
                return self.matchUseCase.fetchMatch(matchId: id)
            }
            
        let myRecords = matches.withLatestFrom(fetchSummoner) { match, summoner in
            return (match,summoner.id)
        }.compactMap { [weak self] match,id in
            return self?.matchUseCase.getMyRecord(in: match, id: id)
        }
        .scan([Participant]()) { lastValue, newValue in
            print("lastValue",lastValue)
            return lastValue + [newValue]
        }.do(onNext: {
            print("records",$0)
        })

            
        
        return Output(
            summonerInfo: Observable.zip(fetchSummoner,fetchLeagueEntry).asDriver(onErrorDriveWith: Driver.empty()),
            matches: matches.asDriver(onErrorDriveWith: .empty()),
            myRecord: myRecords.asDriver(onErrorJustReturn: [])
        )
    }
}
