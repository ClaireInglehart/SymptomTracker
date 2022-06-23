//
//  AppDelegate.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Fixes issue in SVProgressHUD
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureUserNotifications()
        
        return true
    }
    
    private func configureUserNotifications() {
        UNUserNotificationCenter.current().delegate = self
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
//    Screenshots dimensions should be: 1242x2688 2688x1242 1284x2778 2778x1284


    
    
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void ) {
        print("willPresent notification")
        completionHandler(.banner)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        goToCheckins()
        
        completionHandler()
    }
    
    
    func goToCheckins() {
        if let startupVC = self.getStartupViewController() {
            startupVC.doCheckin()
        }
    }
    
    func getStartupViewController() -> StartupViewController? {
        if let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first {
            if let rootVC = keyWindow.rootViewController {
                if let nav = rootVC as? UINavigationController {
                    if let firstVC = nav.viewControllers.first {
                        if let startupVC = firstVC as? StartupViewController {
                            return startupVC
                        }
                    }
                }
            }
        }
        return nil
    }

    
}


