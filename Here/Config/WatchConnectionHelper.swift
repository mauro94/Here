//
//  WatchConnectionHelper.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 4/5/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import Foundation
import WatchConnectivity
import RealmSwift

struct AssignmentWatch {
    var title: String
    var note: String
    var priority: String
    var date: String
    var courseName: String
    var courseColorRed: String
    var courseColorGreen: String
    var courseColorBlue: String
    var courseColorAlpha: String
}

class WatchConnectionHelper: NSObject, WCSessionDelegate {
    // MARK: - Variables
    fileprivate var watchSession: WCSession?
    var assignmentsWatch = [String: [String: String]]()
    let realm = try! Realm()
    var assignments: Results<Assignment>!
    
    // MARK: /Users/mauro/Dropbox/ULTIMO SEMESTRE/Topico iOS/Here/Here.xcodeproj- Constructor
    override init() {
        super.init()
        
        // Session
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
        
        // Get data
        assignments = realm.objects(Assignment.self)
        assignments = assignments!.sorted(byKeyPath: "date", ascending: true)
    }
    
    // MARK: - Functions
    func sendData() {
        prepData()
        do {
            try self.watchSession?.updateApplicationContext(assignmentsWatch)
        } catch {
            print("Error sending data to Apple Watch!")
        }
    }
    
    private func prepData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM-d"
        
        for i in 0..<assignments.count {
            assignmentsWatch[assignments[i].title] = [
                "title": assignments[i].title,
                "note": assignments[i].note,
                "priority": assignments[i].priority,
                "date": formatter.string(from: assignments[i].date!),
                "courseName": (assignments[i].course?.name)!,
                "courseColorRed": "\(assignments[i].course!.red)",
                "courseColorGreen": "\(assignments[i].course!.green)",
                "courseColorBlue": "\(assignments[i].course!.blue)",
                "courseColorAlpha": "\(assignments[i].course!.alpha)"]
        }
    }
    
    // MARK: - Watch Session
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session activation did complete")
    }
    
    public func sessionDidBecomeInactive(_ session: WCSession) {
        print("session did become inactive")
    }
    
    public func sessionDidDeactivate(_ session: WCSession) {
        print("session did deactivate")
    }
}
