//
//  AppDelegate.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//

import UIKit
import IQKeyboardManagerSwift
import FBSDKCoreKit

@available(iOS 13.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    
    var window: UIWindow?
    var database: Database?
    var globalNavigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        database = Database()
        _ = try! database?.setupDatabase(application)
        let rootViewController = UsersWireFrame.createUsersModule()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        globalNavigationController = navigationController
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions )
        
        return true
    }


}
