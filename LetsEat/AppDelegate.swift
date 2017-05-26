//
//  AppDelegate.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/5/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var launchedShortcutItem: UIApplicationShortcutItem?
	static let applicationShortcutUserInfoIconKey = "applicationShortcutUserInfoIconKey"

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		setupDefaultColors()
		checkNotifications()
		
		return chekcShortcut(application, launchOptions: launchOptions)
	}
	
	func checkNotifications() {
		UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (isGranted, error) in
			let optionOne = UNNotificationAction(identifier: Option.one.rawValue, title: "Yes", options: [.foreground])
			let optionTwo = UNNotificationAction(identifier: Option.two.rawValue, title: "No", options: [.foreground])
			
			let category = UNNotificationCategory(identifier: Identifier.reservationCategory.rawValue, actions: [optionOne, optionTwo], intentIdentifiers: [], options: [])
			UNUserNotificationCenter.current().setNotificationCategories([category])
		}
	}
	
	func chekcShortcut(_ application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		var isPerformingAdditionalDelegateHandling = true
		
		if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
			launchedShortcutItem = shortcutItem
			isPerformingAdditionalDelegateHandling = false
		}
		if let shortcutItems = application.shortcutItems, shortcutItems.isEmpty {
			let laShortcut = UIMutableApplicationShortcutItem(type: Shortcut.openLosAngeles.type, localizedTitle: "Los Angeles", localizedSubtitle: "", icon: UIApplicationShortcutIcon(templateImageName: "shortcut-city"), userInfo: nil)
			let lvShortcut = UIMutableApplicationShortcutItem(type: Shortcut.openLasVegas.type, localizedTitle: "Las Vegas", localizedSubtitle: "", icon: UIApplicationShortcutIcon(templateImageName: "shortcut-city"), userInfo: nil)
			application.shortcutItems = [laShortcut, lvShortcut]
		}
		return isPerformingAdditionalDelegateHandling
	}
	
	func handleShortcut(_ item: UIApplicationShortcutItem) -> Bool {
		var isHandled = false
		guard Shortcut(with: item.type) != nil, let shortcutType = item.type as String?, let tabBarController = self.window?.rootViewController as? UITabBarController else {
			print("fucked")
			return false
		}
		switch shortcutType {
		case Shortcut.openLocations.type:
			tabBarController.selectedIndex = 0
			let navController = window!.rootViewController!.childViewControllers.first as! UINavigationController
			let viewController = navController.childViewControllers.first as! ExploreViewController
			viewController.performSegue(withIdentifier: Segue.locationList.rawValue, sender: self)
			isHandled = true
			break
		case Shortcut.openMap.type:
			tabBarController.selectedIndex = 1
			isHandled = true
			break
		case Shortcut.openLosAngeles.type:
			let navController = window?.rootViewController?.childViewControllers.first as? UINavigationController
			let viewController = navController?.childViewControllers.first as? ExploreViewController
			viewController?.selectedCity = "Los Angeles"
			tabBarController.selectedIndex = 1
			tabBarController.selectedIndex = 0
			break
		case Shortcut.openLasVegas.type:
			let navController = window?.rootViewController?.childViewControllers.first as? UINavigationController
			let viewController = navController?.childViewControllers.first as? ExploreViewController
			viewController?.selectedCity = "Las Vegas"
			tabBarController.selectedIndex = 1
			tabBarController.selectedIndex = 0
			break
		default:
			break
		}
		return isHandled
	}
	
	@objc(application:performActionForShortcutItem:completionHandler:) func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool)->Void) {
		let handleShortcutItem = handleShortcut(shortcutItem)
		completionHandler(handleShortcutItem)
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		guard let item = launchedShortcutItem else {
			return
		}
		_ = handleShortcut(item)
		
		launchedShortcutItem = nil
		
		if (application.applicationIconBadgeNumber != 0) {
			application.applicationIconBadgeNumber = 0
		}
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}

	func setupDefaultColors() {
		UITabBar.appearance().tintColor = .black
		UITabBar.appearance().barTintColor = .white
		
		UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.darkGray], for: .normal)
		UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black], for: .selected)
		
		UINavigationBar.appearance().tintColor = .black
		UINavigationBar.appearance().barTintColor = .white
		
		UITabBar.appearance().isTranslucent = false
		UINavigationBar.appearance().isTranslucent = false
	}
}

