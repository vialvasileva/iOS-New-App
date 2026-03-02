//
//  SceneDelegate.swift
//  NewApp
//
//  Created by victoria on 02.03.2026.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let uiKitTab = UINavigationController(rootViewController: FrstViewController())
        uiKitTab.tabBarItem = UITabBarItem(title: "UIKit", image: UIImage(systemName: "swift"), tag: 0)

        let swiftUITab = UINavigationController(rootViewController: UIHostingController(rootView: ScndViewController()))
        swiftUITab.tabBarItem = UITabBarItem(title: "SwiftUI", image: UIImage(systemName: "star.fill"), tag: 1)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [uiKitTab, swiftUITab]

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
