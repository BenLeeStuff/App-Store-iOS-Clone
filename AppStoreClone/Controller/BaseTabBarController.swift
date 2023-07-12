//
//  BaseTabBarController.swift
//  AppStoreClone
//
//  Created by Ben Lee on 7/6/23.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.barTintColor = .white

        viewControllers = [
            createNavController(viewController: AppsPageController(), title: "Apps", imageName: "apps.iphone"),
            createNavController(viewController: AppsSearchController(), title: "Search", imageName: "magnifyingglass"),
            createNavController(viewController: UIViewController(), title: "Today", imageName: "doc.text.image")
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)
        navController.navigationBar.prefersLargeTitles = true
        
        return navController
    }
    
    fileprivate func createNavController(collectionViewController: UICollectionViewController, title: String, imageName: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: collectionViewController)
        collectionViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)
        navController.navigationBar.prefersLargeTitles = true
        
        return navController
    }
    
    
}
