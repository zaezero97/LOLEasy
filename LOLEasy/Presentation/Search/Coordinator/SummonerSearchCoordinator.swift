//
//  SummonerSearchCoordinator.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/25.
//

import UIKit

protocol SummonerSearchCoordinator: Coordinator {
    func showRegisterSummonerScene()
}

final class DefaultSummonerSearchCoordinator: SummonerSearchCoordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        //TODO: 의존성 주입
        let vc = SummonerSearchViewController()
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showRegisterSummonerScene() {
        let vc = RegisterSummonerViewController()
        self.navigationController.pushViewController(vc, animated: true)
    }
}

