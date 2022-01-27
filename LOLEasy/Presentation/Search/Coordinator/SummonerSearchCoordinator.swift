//
//  SummonerSearchCoordinator.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/25.
//

import UIKit

protocol SummonerSearchCoordinator: Coordinator {
    func showRegisterSummonerScene()
    func popRegisterSummonerVC()
}

protocol RegisterSummonerProtocol: AnyObject {
    func registerSummoner(summoner: Summoner)
} 

final class DefaultSummonerSearchCoordinator: SummonerSearchCoordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    weak var delegate: RegisterSummonerProtocol?
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        //TODO: 의존성 주입
        let vc = SummonerSearchViewController()
        let viewModel = SummonerSearchViewModel(coordinator: self)
        vc.viewModel = viewModel
        self.delegate = viewModel
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showRegisterSummonerScene() {
        let vc = RegisterSummonerViewController()
        let summonerRepository = DefaultSummonerRepository(riotAPIDataSource: DefaultRiotAPIDataSource())
        vc.viewModel = RegisterSummonerViewModel(
            summonerInfoUseCase: DefaultSummonerInfoUseCase(summonerRepository: summonerRepository), coordinator: self)
        
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func popRegisterSummonerVC() {
        
        self.navigationController.popViewController(animated: true)
    }
    
}

