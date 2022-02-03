//
//  SummonerRecordCoordinator.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/02/03.
//

import UIKit

protocol SummonerRecordCoordinator: Coordinator {
    
}


final class DefaultSummonerRecordCoordinator: SummonerRecordCoordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() { }
    
    func start(name: String) {
        print("SummonerRecord Start!!! with \(name)")
        let vc = SummonerRecordViewController()
        self.navigationController.pushViewController(vc, animated: true)
    }
}
