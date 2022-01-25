//
//  AppCoordinator.swift
//  LOLEasy
//
//  Created by 재영신 on 2022/01/25.
//

import UIKit

enum TabbarItem: CaseIterable {
    case search
    
    var title: String {
        switch self {
        case .search:
            return "Search"
        }
    }
    
    var icon: (default: UIImage?, selected: UIImage?) {
        switch self {
        case .search:
            return (UIImage(systemName: "magnifyingglass"),UIImage(systemName: "magnifyingglass"))
        }
        
    }
    
    var coordinator: Coordinator {
        switch self {
        case .search:
            return DefaultSummonerSearchCoordinator(navigationController: UINavigationController())
        }
    }
}

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator? // nil
    var childCoordinators = [Coordinator]()
    let tabbarController: UITabBarController
    let navigationController: UINavigationController
    
    init(tabbarController: UITabBarController) {
        self.tabbarController = tabbarController
        self.navigationController = UINavigationController() // 메인을 탭바로 쓰기위해 사용 안한다
    }
    
    func start() {
        let viewControllers: [UIViewController] = TabbarItem.allCases.map {
            let coordinator = $0.coordinator
            let vc = coordinator.navigationController
            self.childCoordinators.append(coordinator)
            coordinator.start()
            vc.tabBarItem = UITabBarItem(
                title: $0.title,
                image: $0.icon.default,
                selectedImage: $0.icon.selected
            )
            return vc
        }
        self.tabbarController.viewControllers = viewControllers
        self.tabbarController.view.backgroundColor = .systemBackground
    }
}
