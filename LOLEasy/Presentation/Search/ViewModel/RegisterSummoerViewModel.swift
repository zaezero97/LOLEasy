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
  
    private let summonerInfoUseCase: SummonerInfoUseCase
    private weak var coordinator: SummonerSearchCoordinator?
    
    
    init(summonerInfoUseCase: SummonerInfoUseCase, coordinator: SummonerSearchCoordinator) {
        self.summonerInfoUseCase = summonerInfoUseCase
        self.coordinator = coordinator
    }
    
    func transform(from input: Input) -> Output {
        //TODO: 소환사 정보가져오는 로직 구현
    
        let fetchSummoner = input.didTapRegisterButton
            .withLatestFrom(input.summonerName)
            .compactMap{ $0 }
            .flatMap(self.summonerInfoUseCase.fetchSummoner)
        
        let errorMessage = fetchSummoner.compactMap { result -> String? in
            switch result {
            case .success(_):
                return nil
            case .failure(let error):
                print("error",error)
                return "소환사 정보를 찾을 수 없습니다!"
            }
        }
            return Output(
                errorMessage: errorMessage.asSignal(onErrorJustReturn: "error")
            )
        }
    }
    
    
    extension RegisterSummonerViewModel {
        struct Input {
            // String -> 소환사 이름
            let didTapRegisterButton: Observable<Void>
            let summonerName: Observable<String?>
        }
        struct Output {
            // String -> 존재하지 않은 사용자 를 입력했다는 메시지
            let errorMessage: Signal<String>
        }
    }
    
    
