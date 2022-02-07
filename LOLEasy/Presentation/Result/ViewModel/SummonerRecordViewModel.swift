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
        //puuid
        let viewDidLoad: Observable<String>
    }
    struct Output{
        
    }
    private let matchUseCase: MatchUseCase
    
    init(matchUseCase: MatchUseCase) {
        self.matchUseCase = matchUseCase
    }
    
    func transform(from input: Input) -> Output {
        print("transform")
        input.viewDidLoad
            .do(onNext: {
                print("puuid",$0)
                self.matchUseCase.fetchMatchIds(puuid: $0)
            }).subscribe()
        return Output()
    }
}
