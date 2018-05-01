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
    @IBOutlet weak var lbTimeRemaining: UILabel!
    @IBOutlet weak var btHere: UIButton!
    
    // MARK: - Variables
    let realm = try! Realm()
    var classes: Results<Class>!
    let locationManager = CLLocationManager()
    var beaconRegion: CLBeaconRegion!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Draw button
        btHere.frame = CGRect(x: btHere.frame.origin.x, y: btHere.frame.origin.y, width: btHere.frame.width, height: btHere.frame.height)
        btHere.layer.cornerRadius = 0.5 * btHere.bounds.size.width
        btHere.clipsToBounds = true
        
        // Get data and filter
        classes = realm.objects(Class.self)
        
        let start = Calendar.current.startOfDay(for: Date())
        let end: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: start)!
        }()
        
        classes = classes.filter("%@ BETWEEN %@", Date(),[start, end])
        data = data.sorted(byKeyPath: "date", ascending: true)
        
        
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
        //
    }
    
    @IBAction func here(_ sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM/dd HH:mm"
        
        let currentTime = formatter.string(from: Date())
        
        let alert = UIAlertController(title: "Success", message: "Assistance has been registered \n\(currentTime)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
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
                    
//                    if hour == Int(c.hour) && minute == Int(c.minute) {
                        btHere.isEnabled = true
                        btHere.alpha = 1
//                    }
//                    else {
//                        btHere.isEnabled = false
//                        btHere.alpha = 0.5
//                    }
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
