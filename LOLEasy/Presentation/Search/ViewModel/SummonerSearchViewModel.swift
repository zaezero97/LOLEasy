//
//  SummonerSearchViewModel.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/25.
//

import Foundation
import RxSwift
import RxCocoa
import CoreMedia

final class SummonerSearchViewModel: ViewModelType {
    
    private weak var coordinator: SummonerSearchCoordinator?
    private let summonerInfoUseCase: SummonerInfoUseCase
    
    init
    (
        coordinator: SummonerSearchCoordinator,
        summonerInfoUseCase: SummonerInfoUseCase
    ) {
        self.coordinator = coordinator
        self.summonerInfoUseCase = summonerInfoUseCase
    }
    
    func transform(from input: Input) -> Output {
        
        let showRegisterView = input.didTapRegisterSummonerView
            .do(onNext: {
                [weak self] _ in
                self?.coordinator?.showRegisterSummonerScene()
            })
        
        let registeredSummonerName = input.viewWillAppear
            .map {
                [weak self] () -> String? in
                return self?.summonerInfoUseCase.fetchRegisteredSummoner()
            }
        
        let fetchSummonerResult = registeredSummonerName
            .compactMap{ $0 } //optional 제거
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
            showRegisterView: showRegisterView.asSignal(onErrorJustReturn: ()),
            summonerInfo: Observable.zip(fetchSummoner,fetchLeagueEntry).asDriver(onErrorDriveWith: Driver.empty())
        )
    }
    
    
}


extension SummonerSearchViewModel {
    struct Input {
        let viewDidLoad: Observable<Void>
        let didTapRegisterSummonerView: Observable<Void>
        let viewWillAppear: Observable<Void>
    }
    
    struct Output {
        let showRegisterView: Signal<Void>
        let summonerInfo: Driver<(Summoner,LeagueEntry)>
    }
}
