//
//  AppDelegate.swift
//  JLTechTest
//
//  Created by Omer Janjua on 17/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
            let window = UIWindow(frame: UIScreen.main.bounds)
            let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
            let productCollectionViewController = navigationController.viewControllers[0] as! ProductCollectionViewController
            let request = JLRequest(baseURL: URL(string: "https://api.johnlewis.com/v1")!)
            let presenter = ProductPresenter(
                productInteractor: ProductInteractor(request: request),
                imageInteractor: ImageInteractor(),
                view: productCollectionViewController,
                router: PushingProductDetailRouter(navigationController: navigationController)
            )
            productCollectionViewController.eventHandler = presenter
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            self.window = window
            return true
    }
}

