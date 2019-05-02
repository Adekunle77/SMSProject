//
//  AppDelegate.swift
//  SMSProject
//
//  Created by Ade Adegoke on 12/04/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        SaveData.saveContext()
    }

}

