//
//  SummonerSearchViewModel.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/25.
//

import Foundation
import RxSwift
import RxCocoa


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
        
        let unRegister = input.didTapUnRegisterButton
            .do{
                [weak self] _ in
                self?.summonerInfoUseCase.unRegisterSummoner()
            }
        
        let searchSummoner = input.didTapSearchButton
            .do(onNext: {
                [weak self] name in
                self?.coordinator?.showSearchResult(name: name)
            }).mapToVoid()
        
        return Output(
            showRegisterView: showRegisterView.asSignal(onErrorJustReturn: ()),
            summonerInfo: Observable.zip(fetchSummoner,fetchLeagueEntry).asDriver(onErrorDriveWith: Driver.empty()),
            unRegister: unRegister.asSignal(onErrorJustReturn: ()),
            searchSummoner: searchSummoner.asSignal(onErrorJustReturn: ())
        )
    }
    
    
}


extension SummonerSearchViewModel {
    struct Input {
        let viewDidLoad: Observable<Void>
        let didTapRegisterSummonerView: Observable<Void>
        let viewWillAppear: Observable<Void>
        let didTapUnRegisterButton: Observable<Void>
        let didTapSearchButton: Observable<String>
    }
    
    struct Output {
        let showRegisterView: Signal<Void>
        let summonerInfo: Driver<(Summoner,LeagueEntry)>
        let unRegister: Signal<Void>
        let searchSummoner: Signal<Void>
    }
}
