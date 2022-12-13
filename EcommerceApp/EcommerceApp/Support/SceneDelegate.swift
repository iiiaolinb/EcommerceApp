//
//  SceneDelegate.swift
//  EcommerceApp
//
//  Created by Егор Худяев on 03.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)

        let router = Router(rootTransition: Transition())
        let tabs = [router.makeHomeScreen(),
                    router.makeDetailsScreen(),
                    router.makeFavoriteScreen(),
                    router.makeProfileScreen()]
        let tabBar = UITabBarController()
        tabBar.viewControllers = tabs
        router.root = tabBar

        configure(tabBar)
        
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
    }

    private func configure(_ tabBar: UITabBarController) {
        tabBar.tabBar.backgroundColor = Constants.Colors.darkBlue
        tabBar.tabBar.layer.masksToBounds = true
        tabBar.tabBar.tintColor = .white
        tabBar.tabBar.barStyle = .black
        tabBar.tabBar.layer.cornerRadius = 20
        tabBar.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

