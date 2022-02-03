//
//  SummonerSearchCoordinator.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/25.
//

import UIKit

protocol SummonerSearchCoordinator: Coordinator {
    func showRegisterSummonerScene()
    func popToRootVC()
}

protocol RegisterSummonerDelegate: AnyObject {
    func registerSummoner(summoner: Summoner)
} 



final class DefaultSummonerSearchCoordinator: SummonerSearchCoordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    weak var delegate: RegisterSummonerDelegate?
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        //TODO: 의존성 주입
        let vc = SummonerSearchViewController()
        let summonerRepository = DefaultSummonerRepository(riotAPIDataSource: DefaultRiotAPIDataSource())
        let viewModel = SummonerSearchViewModel(coordinator: self,summonerInfoUseCase: DefaultSummonerInfoUseCase(summonerRepository: summonerRepository))
        vc.viewModel = viewModel
        //self.delegate = viewModel
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showRegisterSummonerScene() {
        let vc = RegisterSummonerViewController()
        let summonerRepository = DefaultSummonerRepository(riotAPIDataSource: DefaultRiotAPIDataSource())
        vc.viewModel = RegisterSummonerViewModel(
            summonerInfoUseCase: DefaultSummonerInfoUseCase(summonerRepository: summonerRepository), coordinator: self)
        
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func popToRootVC() {
        self.navigationController.popToRootViewController(animated: true)
    }
    
}

