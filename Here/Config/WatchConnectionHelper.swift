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
    func sendData(message: String, assignment: Assignment) {
        prepData(message: message, assignment: assignment)
        do {
            try self.watchSession?.updateApplicationContext(assignmentsWatch)
        } catch {
            print("Error sending data to Apple Watch!")
        }
    }
    
    private func prepData(message: String, assignment: Assignment) {
        assignmentsWatch = [String: [String: String]]()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM-d"
        
        assignmentsWatch[message] = [
            "title": assignment.title,
            "note": assignment.note,
            "priority": assignment.priority,
            "date": formatter.string(from: assignment.date!),
            "courseName": (assignment.classCourse?.course!.name)!,
            "courseColorRed": "\(assignment.classCourse!.red)",
            "courseColorGreen": "\(assignment.classCourse!.green)",
            "courseColorBlue": "\(assignment.classCourse!.blue)",
            "courseColorAlpha": "\(assignment.classCourse!.alpha)"]
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
