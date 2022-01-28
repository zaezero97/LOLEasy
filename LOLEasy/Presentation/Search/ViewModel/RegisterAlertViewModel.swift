//
//  RegisterAlertViewModel.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/28.
//

import Foundation
import RxSwift
import RxCocoa

final class RegisterAlertViewModel: ViewModelType {
    
    struct Input {
        let summonerInfo: Observable<(Summoner,LeagueEntry)>
        let didTapRegisterButton: Observable<Void>
    }
    
    struct Output {
        let register: Driver<Void>
    }
    
    func transform(from input: Input) -> Output {
        
        return Output(register: input.didTapRegisterButton.asDriver(onErrorDriveWith: Driver.empty()))
    }
}


