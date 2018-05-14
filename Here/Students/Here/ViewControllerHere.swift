//
//  ViewControllerHere.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 4/3/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import CoreLocation
import RealmSwift

class ViewControllerHere: UIViewController, CLLocationManagerDelegate {
    // MARK: - Outlets
//    @IBOutlet weak var btAbsence: UIButton!
//    @IBOutlet weak var btAssignment: UIButton!
    @IBOutlet weak var btHere: UIButton!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbRoom: UILabel!
    @IBOutlet weak var btAbsences: UIButton!
    
    // MARK: - Variables
    let realm = try! Realm()
    var classes: Results<Class>!
    let locationManager = CLLocationManager()
    var beaconRegion: CLBeaconRegion!
    var currentClass: Class?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Draw button
        btHere.frame = CGRect(x: btHere.frame.origin.x, y: btHere.frame.origin.y, width: btHere.frame.width, height: btHere.frame.height)
        btHere.layer.cornerRadius = 0.5 * btHere.bounds.size.width
        btHere.clipsToBounds = true
        
        // Remove navbar shadow
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        // Button design
        btAbsences.layer.cornerRadius = 8.0
        
        // Get data and filter
        classes = realm.objects(Class.self)
        
        // Filter classes
        getTodayClasses()
        
        // iBeacons
        locationManager.delegate = self
        
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
            if CLLocationManager.isRangingAvailable() {
                for i in 0 ..< classes.count {
                    if classes[i].beaconUUID != "" {
                        startMonitoringProject(i: i)
                    }
                }
            }
        }
        
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Filter classes
        getTodayClasses()
        
        // Get current class
        getCurrentClass()
        
        // Display data
        if currentClass != nil {
            self.navigationItem.title = currentClass?.course?.name
            lbTime.text = (currentClass?.hour)! + ":" + (currentClass?.minute)! + " (" + (currentClass?.duration)! + "hrs)"
            lbRoom.text = (currentClass?.building)! + "-" + (currentClass?.room)!
            btAbsences.isEnabled = true
        }
        else {
            self.navigationItem.title = "No more classes!"
            lbTime.text = ""
            lbRoom.text = ""
            btAbsences.isEnabled = false
        }
    }
    
    @IBAction func here(_ sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM/dd HH:mm"
        
        let currentTime = formatter.string(from: Date())
        
        let alert = UIAlertController(title: "Success", message: "Assistance has been registered \n\(currentTime)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Functions
    func getTodayClasses() {
        let today = Calendar.current.startOfDay(for: Date())
        let weekday = Calendar.current.component(.weekday, from: today)
        
        switch weekday {
        case 1:
            classes = classes.filter("sunday = true")
        case 2:
            classes = classes.filter("monday = true")
        case 3:
            classes = classes.filter("tuesday = true")
        case 4:
            classes = classes.filter("wednesday = true")
        case 5:
            classes = classes.filter("thursday = true")
        case 6:
            classes = classes.filter("friday = true")
        default:
            classes = classes.filter("saturday = true")
        }
        
        classes = classes.sorted(byKeyPath: "hour")
    }
    
    func getCurrentClass() {
        let hour = Calendar.current.component(.hour, from: Date())
        currentClass = nil
        
        for c in classes {
            if Int(c.hour)! >= hour {
                currentClass = c
                break
            }
        }
    }
    
    @IBAction func checkAbsences(_ sender: UIButton) {
        let alert = UIAlertController(title: "Remaining Absences", message: "5", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Location
    func startMonitoringProject(i: Int) {
        let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: classes[i].beaconUUID)!,
                                          major: UInt16(classes[i].beaconMajor)!,
                                          minor: UInt16(classes[i].beaconMinor)!,
                                          identifier: (classes[i].course?.name)!)
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if (beacons.count > 0) {
            for beacon in beacons {
                let beaconClass = realm.objects(Class.self).filter("beaconUUID = %@ AND beaconMajor = %@ AND beaconMinor = %@", "\(beacon.proximityUUID)", "\(beacon.major)", "\(beacon.minor)")
                if beaconClass.count > 0 {
                    let c = beaconClass[0]
                    
                    let date = Date()
                    let calendar = Calendar.current
                    let hour = calendar.component(.hour, from: date)
                    let minute = calendar.component(.minute, from: date)

                    
                    if hour == Int(c.hour)! && (minute >= (Int(c.minute)! - 5) && minute <= (Int(c.minute)! + 20)) {
                        btHere.isEnabled = true
                        btHere.alpha = 1
                    }
                    else {
                        btHere.isEnabled = false
                        btHere.alpha = 0.5
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print(error)
    }
    
    
    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        print(error)
    }

}
