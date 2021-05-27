//
//  SceneDelegate.swift
//  Bosegwon
//
//  Created by 신민희 on 2021/05/27.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                window = UIWindow(windowScene: windowScene)
        let firstView  = ViewController()
        let StoreView = StoreViewController()
        let myPageView = MyPageViewController()
        let naviLoginView = UINavigationController(rootViewController: myPageView)
        firstView.tabBarItem = UITabBarItem(title: "가게 지도", image: UIImage(systemName: "map"), tag: 0)
        StoreView.tabBarItem = UITabBarItem(title: "등록하기", image: UIImage(systemName: "cart.badge.plus"), tag: 0)
        naviLoginView.tabBarItem = UITabBarItem(title: "내 정보", image: UIImage(systemName: "person"), tag: 0)
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [firstView, StoreView, naviLoginView]
        UINavigationBar.setTransparentTabbar()
        window?.rootViewController = tabBarController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}
}
extension UINavigationBar {
        
        static func setTransparentTabbar() {
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            UINavigationBar.appearance().shadowImage     = UIImage()
            UINavigationBar.appearance().clipsToBounds   = true
        } // 네비게이션바 투명하게 처리
}
