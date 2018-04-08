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
            let noCourse = Course(id: "", name: "No Course", department: "")
            // ERASE OTHER COURSES
            let course1 = Course(id: "TC2011", name: "Sistemas Inteligentes", department: "Ciencias Computacionales")
            let course2 = Course(id: "TC3035", name: "Introducción a la vida profesional", department: "Ciencias Computacionales")
            let course3 = Course(id: "HS2006", name: "Ética aplicada", department: "Humanidades")
            let course4 = Course(id: "TC3054", name: "Proyecto integrador para el desarrollo de soluciones empresariales", department: "Ciencias Computacionales")
            
            try! realm.write {
                realm.add(noCourse)
                realm.add(course1)
                realm.add(course2)
                realm.add(course3)
                realm.add(course4)
            }
        }
        
        // TEMP ERASE
        let student = Student(id: "A01191903", name: "Mauro", lastName: "Amarante", degree: "ITC", device: "AA")
        try! realm.write {
            realm.add(student)
        }
        
        let classes = realm.objects(Class.self)
        let course = realm.objects(Course.self)
        if classes.count == 0 {
            let r0 = Float(52/255)
            let g0 = Float(58/255)
            let b0 = Float(64/255)
            let c0 = Class(group: "", building: "", room: "", red: r0, green: g0, blue: b0, alpha: 1.0, course: course[0])
            let r1 = Float(arc4random()) / Float(UINT32_MAX)
            let g1 = Float(arc4random()) / Float(UINT32_MAX)
            let b1 = Float(arc4random()) / Float(UINT32_MAX)
            let c1 = Class(group: "101", building: "A3", room: "303", beaconUUID: "B0702880-A295-A8AB-F734-031A98A512DA", beaconMinor: "1001", beaconMajor: "1", hour: "10", minute: "30", duration: "1.5", startDay: "9", startMonth: "1", startYear: "2018", endDay: "3", endMonth: "5", endYear: "2018", sunday: false, monday: true, tuesday: false, wednesday: false, thursday: true, friday: false, saturday: false, red: r1, green: g1, blue: b1, alpha: 1.0, course: course[1])
            let r2 = Float(arc4random()) / Float(UINT32_MAX)
            let g2 = Float(arc4random()) / Float(UINT32_MAX)
            let b2 = Float(arc4random()) / Float(UINT32_MAX)
            let c2 = Class(group: "102", building: "A3", room: "101", beaconUUID: "B0702880-A295-A8AB-F734-031A98A512DA", beaconMinor: "1002", beaconMajor: "2", hour: "12", minute: "00", duration: "1.5", startDay: "9", startMonth: "1", startYear: "2018", endDay: "3", endMonth: "5", endYear: "2018", sunday: false, monday: true, tuesday: false, wednesday: false, thursday: true, friday: false, saturday: false, red: r2, green: g2, blue: b2, alpha: 1.0, course: course[2])
            let r3 = Float(arc4random()) / Float(UINT32_MAX)
            let g3 = Float(arc4random()) / Float(UINT32_MAX)
            let b3 = Float(arc4random()) / Float(UINT32_MAX)
            let c3 = Class(group: "102", building: "CIAP", room: "404", beaconUUID: "B0702880-A295-A8AB-F734-031A98A512DA", beaconMinor: "1003", beaconMajor: "3", hour: "16", minute: "00", duration: "1.5", startDay: "9", startMonth: "1", startYear: "2018", endDay: "3", endMonth: "5", endYear: "2018", sunday: false, monday: false, tuesday: true, wednesday: false, thursday: false, friday: true, saturday: false, red: r3, green: g3, blue: b3, alpha: 1.0, course: course[3])
            let r4 = Float(arc4random()) / Float(UINT32_MAX)
            let g4 = Float(arc4random()) / Float(UINT32_MAX)
            let b4 = Float(arc4random()) / Float(UINT32_MAX)
            let c4 = Class(group: "102", building: "A3", room: "312", beaconUUID: "B0702880-A295-A8AB-F734-031A98A512DA", beaconMinor: "1004", beaconMajor: "4", hour: "14", minute: "30", duration: "3", startDay: "9", startMonth: "1", startYear: "2018", endDay: "3", endMonth: "5", endYear: "2018", sunday: false, monday: false, tuesday: false, wednesday: true, thursday: false, friday: false, saturday: false, red: r4, green: g4, blue: b4, alpha: 1.0, course: course[4])

            try! realm.write {
                realm.add(c0)
                realm.add(c1)
                realm.add(c2)
                realm.add(c3)
                realm.add(c4)
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

