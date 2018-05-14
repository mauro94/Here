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

class WatchConnectionHelper: NSObject, WCSessionDelegate {
    // MARK: - Variables
    fileprivate var watchSession: WCSession?
    var assignmentsWatch = [String: [String: String]]()
    let realm = try! Realm()
    var assignments: Results<Assignment>!
    
    // MARK: Constructor
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
            "complete": "\(assignment.complete)",
            "courseColorRed": "\(assignment.classCourse!.red)",
            "courseColorGreen": "\(assignment.classCourse!.green)",
            "courseColorBlue": "\(assignment.classCourse!.blue)",
            "courseColorAlpha": "\(assignment.classCourse!.alpha)"]
    }
    
    private func storeDataComplete(data: [String: Any]) {
        let tempAssignments = data as! [String: [String: String]]
        let realm = try! Realm()
        for (message, assignment) in tempAssignments {
            let predicate = NSPredicate(format: "title = %@", message)
            let a = realm.objects(Assignment.self).filter(predicate)[0]
            try! realm.write {
                if assignment["complete"] == "true" {
                    a.complete = true
                    a.completeDate = Date()
                }
                else {
                    a.complete = false
                    a.completeDate = nil
                }
            }
        }
    }
    
    private func registerAssistance() {
        
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
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        print("iphone received app context")
        
        let temp = applicationContext as! [String: [String: String]]
        
        if temp["assistance"]?["assistance"] == "true" {
            
        }
        else {
            storeDataComplete(data: applicationContext)
        }
    }
}
