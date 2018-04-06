//
//  WatchConnectionHelper.swift
//  Here Watch Extension
//
//  Created by Mauro Amarante Esparza on 4/5/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import Foundation
import WatchConnectivity
import RealmSwift

class WatchConnectionHelper: NSObject, WCSessionDelegate {
    // MARK: - Variables
    fileprivate var watchSession: WCSession?
    
    // MARK: - Constructor
    override init() {
        super.init()
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
    }
    
    // MARK: Functions
    private func storeData(data: [String: Any]) {
        let tempAssignments = data as! [String: [String: String]]
        let realm = try! Realm()

        for (_, assignment) in tempAssignments {
            let a = AssignmentEnhanced(
                title: assignment["title"]!,
                note: assignment["note"]!,
                priority: assignment["priority"]!,
                date: assignment["date"]!,
                courseName: assignment["courseName"]!,
                courseColorRed: Float(assignment["courseColorRed"]!)!,
                courseColorGreen: Float(assignment["courseColorGreen"]!)!,
                courseColorBlue: Float(assignment["courseColorBlue"]!)!,
                courseColorAlpha: Float(assignment["courseColorAlpha"]!)!)
            
            try! realm.write {
                realm.add(a)
            }
        }
    }
    
    // MARK: - Watch Session
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session activation did complete")
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        print("watch received app context")
        storeData(data: applicationContext)
        
        //        if let temperature = applicationContext[] as? Assignment {
        //            self.temperatureLabel.setText(temperature + "℃")
        //        }
        //
        //        if let connected = applicationContext[DataKey.BLEConnected] as? Bool {
        //            self.temperatureLabel.setTextColor(connected == true ? UIColor.white : UIColor.red)
        //        }
    }
}
