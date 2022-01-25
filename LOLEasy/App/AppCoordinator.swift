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
    
    //    var vc: UIViewController {
    //        switch self {
    //        case .search:
    //            return SummonerSearchViewController()
    //        case .ranking:
    //            return UIViewController()
    //        }
    //    }
    
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
    var tabbarController: UITabBarController
    let navigationController: UINavigationController
    init(tabbarController: UITabBarController) {
        self.tabbarController = tabbarController
        self.navigationController = UINavigationController() // 메인을 탭바로 쓰기위해 사용 안한다
    }
    
    func start() {
        
        self.tabbarController.viewControllers = TabbarItem.allCases.map {
                let vc = $0.coordinator.navigationController
                vc.tabBarItem = UITabBarItem(
                    title: $0.title,
                    image: $0.icon.default,
                    selectedImage: $0.icon.selected
                )
                $0.coordinator.start()
                return vc
            }
        self.tabbarController.view.backgroundColor = .systemBackground
    }
}
