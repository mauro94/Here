//
//  AppDelegate.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 1/11/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var watchConnectionHelper = WatchConnectionHelper()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Color
        let darkColor = UIColor(red: 52/255, green: 58/255, blue: 64/255, alpha: 1)
        
        // Tab bar color
        UITabBar.appearance().barTintColor = darkColor
        UITabBar.appearance().tintColor = UIColor.white
        
        // Create empty course
        let realm = try! Realm()
        let courses = realm.objects(Course.self)
        if courses.count == 0 {
            let noCourse = Course(name: "No Course", group: "", building: "", room: "")
            try! realm.write {
                realm.add(noCourse)
            }
        }
        
        // TEMP ERASE
        let classes = realm.objects(Class.self)
        let course = realm.objects(Course.self)[0]
        if classes.count == 0 {
            let c = Class(group: "101", building: "A3", room: "303", beaconUUID: "B0702880-A295-A8AB-F734-031A98A512DA", beaconMinor: "1001", beaconMajor: "1", hour: "10", minute: "30", duration: "1.5", startDay: "9", startMonth: "1", startYear: "2018", endDay: "3", endMonth: "5", endYear: "2018", sunday: false, monday: true, tuesday: false, wednesday: false, thursday: true, friday: false, saturday: false, course: course)
            
            try! realm.write {
                realm.add(c)
            }
        }
        
        return true
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


}

