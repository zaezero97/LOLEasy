//
//  RegisterSummoerViewModel.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/26.
//

import Foundation
import RxSwift
import RxCocoa

final class RegisterSummonerViewModel: ViewModelType {
    
    struct Input {
        // String -> 소환사 이름
        let didTapSearchButton: Observable<Void>
        let didTapRegisterButton: Observable<Void>
        let summonerName: Observable<String?>
    }
    struct Output {
        // String -> 존재하지 않은 사용자 를 입력했다는 메시지
        let errorMessage: Signal<String>
        let summonerInfo: Driver<(Summoner,LeagueEntry)>
    }
    
    private let summonerInfoUseCase: SummonerInfoUseCase
    private weak var coordinator: SummonerSearchCoordinator?
    
     
    init(
        summonerInfoUseCase: SummonerInfoUseCase,
        coordinator: SummonerSearchCoordinator
    ) {
        self.summonerInfoUseCase = summonerInfoUseCase
        self.coordinator = coordinator
    }
    
    func transform(from input: Input) -> Output {
        //TODO: 소환사 정보가져오는 로직 구현
        
        let fetchSummonerResult = input.didTapSearchButton
            .withLatestFrom(input.summonerName)
            .compactMap{ $0 }
            .flatMap(self.summonerInfoUseCase.fetchSummoner)
            .share()
        
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
        
        let errorMessage = fetchSummonerResult.compactMap { result -> String? in
            guard case let .failure(error) = result else { return nil }
            print("error",error)
            return "소환사 정보를 찾을 수 없습니다!"
        }
            
        
      
        return Output(
            errorMessage: errorMessage.asSignal(onErrorJustReturn: "error"),
            summonerInfo: Observable.zip(fetchSummoner,fetchLeagueEntry).asDriver(onErrorDriveWith: Driver.empty())
        )
    }
}




