//
//  SceneDelegate.swift
//  FakeStore
//
//  Created by leewonseok on 2023/03/27.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windonScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windonScene)
        
        var rootViewController: UIViewController = OnBoardViewController()
        
        if !isFirstTime() {
            rootViewController = LoginViewController()
        }
        
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        
        self.window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
    
    func isFirstTime() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "isFirstTime") == nil {
            defaults.set("No", forKey:"isFirstTime")
            return true
        } else {
            return false
        }
    }
}
