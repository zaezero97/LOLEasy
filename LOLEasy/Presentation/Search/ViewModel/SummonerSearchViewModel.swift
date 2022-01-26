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
    init(coordinator: SummonerSearchCoordinator) {
        self.coordinator = coordinator
    }
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        input.didTapRegisterSummonerView
            .subscribe(onNext: {
                
            }).disposed(by: disposeBag)
        
        return Output()
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
