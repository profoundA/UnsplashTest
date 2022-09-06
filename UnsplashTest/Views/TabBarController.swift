//
//  TabBarController.swift
//  UnsplashTest
//
//  Created by Andrey Lobanov on 05.09.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        let photoTab = UINavigationController(rootViewController: ViewController())
        let photoTabItem = UITabBarItem(
            title: "Фото",
            image: UIImage(systemName: "photo"),
            selectedImage: UIImage(systemName: "photo"))
        photoTab.tabBarItem = photoTabItem
        
        let favoritesTab = UINavigationController(rootViewController: FavoritesViewController())
        let favoritesTabItem = UITabBarItem(
            title: "Избранное",
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star"))
        favoritesTab.tabBarItem = favoritesTabItem
        
        self.viewControllers = [photoTab, favoritesTab]
        
    }
}
