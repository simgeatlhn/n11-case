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
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        
        let homeViewController = HomeRouter.createModule()
        let homeNav = UINavigationController(rootViewController: homeViewController)
        homeNav.tabBarItem = UITabBarItem(title: "Ana Sayfa",
                                          image: UIImage(systemName: "house"),
                                          selectedImage: UIImage(systemName: "house.fill"))
        
        let categoriesVC = HomeRouter.createModule()
        let categoriesNav = UINavigationController(rootViewController: categoriesVC)
        categoriesNav.tabBarItem = UITabBarItem(title: "Kategoriler",
                                                image: UIImage(systemName: "square.grid.2x2"),
                                                selectedImage: UIImage(systemName: "square.grid.2x2.fill"))
        
        let cartVC = HomeRouter.createModule()
        let cartNav = UINavigationController(rootViewController: cartVC)
        cartNav.tabBarItem = UITabBarItem(title: "Sepetim",
                                          image: UIImage(systemName: "cart"),
                                          selectedImage: UIImage(systemName: "cart.fill"))
        
        let listsVC = HomeRouter.createModule()
        let listsNav = UINavigationController(rootViewController: listsVC)
        listsNav.tabBarItem = UITabBarItem(title: "Listelerim",
                                           image: UIImage(systemName: "heart"),
                                           selectedImage: UIImage(systemName: "heart.fill"))
        
        let accountVC = HomeRouter.createModule()
        let accountNav = UINavigationController(rootViewController: accountVC)
        accountNav.tabBarItem = UITabBarItem(title: "Hesabım",
                                             image: UIImage(systemName: "person"),
                                             selectedImage: UIImage(systemName: "person.fill"))
        
        viewControllers = [homeNav, categoriesNav, cartNav, listsNav, accountNav]
        tabBar.tintColor = .customPurpleColor
        tabBar.unselectedItemTintColor = .gray
    }
}
