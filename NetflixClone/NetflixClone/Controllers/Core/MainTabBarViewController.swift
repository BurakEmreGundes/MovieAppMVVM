//
//  ViewController.swift
//  NetflixClone
//
//  Created by Burak Emre gündeş on 10.07.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
       

    }

    private func configure(){
       // UITabBar.appearance().barTintColor = .baseColor
        //UITabBar.appearance().selectedImageTintColor = .primaryColor

        //tabBar.isTranslucent = false
       // UITabBar.appearance().backgroundColor = .baseColor
        tabBar.tintColor = .label
        setupVCs()
    }

    private func setupVCs() {
          viewControllers = [
            createNavController(for: HomeViewController(viewModel: HomeViewModel()), title: "Home", tabbarItem: UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)),
            createNavController(for: UpcomingViewController(viewModel: UpcomingViewModel()), title: "Coming Soon", tabbarItem: UITabBarItem(title: "Coming Soon", image: UIImage(systemName: "play.circle"), tag: 1)),
            createNavController(for: SearchViewController(viewModel: SearchViewModel()), title: "Top Search", tabbarItem: UITabBarItem(title: "Top Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)),
            createNavController(for: DownloadsViewController(), title: "Downloads", tabbarItem: UITabBarItem(title: "Downloads", image: UIImage(systemName: "arrow.down.to.line"), tag: 1)),
          ]
    }
 

    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String, tabbarItem : UITabBarItem) -> UIViewController {
        //rootViewController.title = title
            rootViewController.navigationItem.largeTitleDisplayMode = .always
          let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem = tabbarItem
        navController.navigationBar.tintColor = .label
          return navController
      }
}

