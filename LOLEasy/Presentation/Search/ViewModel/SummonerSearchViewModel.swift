//
//  SummonerSearchViewModel.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/25.
//

import Foundation
import RxSwift

final class SummonerSearchViewModel: ViewModelType {

    private weak var coordinator: SummonerSearchCoordinator?
    //private let summonerInfoUseCase: SummonerInfoUseCase
    
    init(coordinator: SummonerSearchCoordinator) {
        self.coordinator = coordinator
        
    }
    
    func transform(from input: Input) -> Output {
//        input.didTapRegisterSummonerView
//            .do(onNext:self.coordinator?.showRegisterSummonerScene)
//
        _ = input.didTapRegisterSummonerView
            .do(onNext: { [weak self] _ in
                self?.coordinator?.showRegisterSummonerScene()
            })
        
        return Output()
    }
    
    
}

extension SummonerSearchViewModel:RegisterSummonerProtocol {
    func registerSummoner(summoner: Summoner) {
        
    }
}

extension SummonerSearchViewModel {
    struct Input {
        let viewDidLoad: Observable<Void>
        let didTapRegisterSummonerView: Observable<Void>
    }
    
    struct Output {
        
    }
}
