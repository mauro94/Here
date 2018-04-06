//
//  WatchConnectionHelper.swift
//  Here Watch Extension
//
//  Created by Mauro Amarante Esparza on 4/5/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import Foundation
import WatchConnectivity

struct Assignment: Codable {
    var title: String
    var note: String
    var priority: String
    var date: String
    var courseName: String
    var courseColorRed: Float
    var courseColorGreen: Float
    var courseColorBlue: Float
    var courseColorAlpha: Float
}

class WatchConnectionHelper: NSObject, WCSessionDelegate {
    // MARK: - Variables
    fileprivate var watchSession: WCSession?
    var assignments = [Assignment]()
    
    // MARK: - Constructor
    override init() {
        super.init()
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
    }
    
    // MARK: Functions
    func getAssignments() -> [Assignment]{
        return assignments
    }
    
    private func storeData(data: [String: Any]) {
        let tempAssignments = data as! [String: [String: String]]
        for (_, assignment) in tempAssignments {
            let a = Assignment(
                title: assignment["title"]!,
                note: assignment["note"]!,
                priority: assignment["priority"]!,
                date: assignment["date"]!,
                courseName: assignment["courseName"]!,
                courseColorRed: Float(assignment["courseColorRed"]!)!,
                courseColorGreen: Float(assignment["courseColorGreen"]!)!,
                courseColorBlue: Float(assignment["courseColorBlue"]!)!,
                courseColorAlpha: Float(assignment["courseColorAlpha"]!)!)
            
            assignments.append(a)
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
