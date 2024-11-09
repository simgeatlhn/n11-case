//
//  TabBarViewController.swift
//  n11-case
//
//  Created by simge on 7.11.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        configureAppearance()
        viewControllers = TabBarController.tabBarItems.map { createNavController(for: $0) }
        tabBar.tintColor = .customPurpleColor
        tabBar.unselectedItemTintColor = .gray
    }
    
    private func configureAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
    }
    
    private func createNavController(for item: TabBarItem) -> UIViewController {
        let viewController = HomeRouter.createModule()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = UITabBarItem(
            title: item.title,
            image: UIImage(systemName: item.imageName),
            selectedImage: UIImage(systemName: item.selectedImageName)
        )
        return navController
    }
}

private extension TabBarController {
    struct TabBarItem {
        let title: String
        let imageName: String
        let selectedImageName: String
    }
    
    static let tabBarItems: [TabBarItem] = [
        TabBarItem(title: "Ana Sayfa", imageName: "house", selectedImageName: "house.fill"),
        TabBarItem(title: "Kategoriler", imageName: "square.grid.2x2", selectedImageName: "square.grid.2x2.fill"),
        TabBarItem(title: "Sepetim", imageName: "cart", selectedImageName: "cart.fill"),
        TabBarItem(title: "Listelerim", imageName: "heart", selectedImageName: "heart.fill"),
        TabBarItem(title: "Hesabım", imageName: "person", selectedImageName: "person.fill")
    ]
}
