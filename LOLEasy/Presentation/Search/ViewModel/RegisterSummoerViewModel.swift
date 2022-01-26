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
    
    init(summonerInfoUseCase: SummonerInfoUseCase) {
        self.summonerInfoUseCase = summonerInfoUseCase
    }
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        //TODO: 소환사 정보가져오는 로직 구현 
        let errorMessage = PublishRelay<String>()
        
        input.didTapRegisterButton
            .withLatestFrom(input.summonerName)
            .compactMap{ $0 }
            .do(onNext: {
                print($0)
            })
            .subscribe(onNext: { [weak self] id in
                self?.summonerInfoUseCase.fetchSummoner(id: id)
                    .subscribe(
                        onSuccess: { summoner in
                        print(summoner)
                        },
                        onFailure: { error in
                            print("error!!",error)
                            errorMessage.accept("소환사 정보를 찾을 수 없습니다.!!")
                        }
                    ).disposed(by: disposeBag)
                    
            }).disposed(by: disposeBag)
    
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
