//
//  AppDelegate.swift
//  Where is my car?
//
//  Created by Student on 03.01.2018.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager:CLLocationManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self

      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: { (stat, error) in })
        
        UIApplication.shared.registerForRemoteNotifications()
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        // Print notification payload data
        print("Push notification received: \(data)")
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("Zaczalem moniotring regionu")
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("BLAD BLAD")
        print (error)
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        switch state {
        case .unknown:
            print("unknown : \(region.identifier)")
        case .inside:
            print("inside : \(region.identifier)")
        case .outside:
            print("outside : \(region.identifier)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Wyszedlem z regionu")
        print(region)
        if(UIApplication.shared.applicationState == .active){
            let alert = UIAlertController(title: region.identifier, message: "Jestes za daleko", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            //handler to kod wykonany po kliknieciu
            window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
            
        else{
            let content = UNMutableNotificationContent()
            content.body = "Jestes za daleko!"
            content.title = region.identifier
            content.sound = UNNotificationSound.default()
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
            let n = UNNotificationRequest(identifier: content.title, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(n, withCompletionHandler: nil)
        }
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
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func applicationDidFinishLaunching(_ application: UIApplication) {
        
    }
}

