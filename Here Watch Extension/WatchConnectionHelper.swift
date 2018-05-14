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
    var assignmentsiPhone = [String: [String: String]]()
    var assistanceiPhone = [String: [String: String]]()
    
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
        for (message, assignment) in tempAssignments {
            switch message {
                case "new":
                    let a = AssignmentEnhanced(
                        title: assignment["title"]!,
                        note: assignment["note"]!,
                        priority: assignment["priority"]!,
                        date: assignment["date"]!,
                        courseName: assignment["courseName"]!,
                        complete: assignment["complete"]!,
                        courseColorRed: Float(assignment["courseColorRed"]!)!,
                        courseColorGreen: Float(assignment["courseColorGreen"]!)!,
                        courseColorBlue: Float(assignment["courseColorBlue"]!)!,
                        courseColorAlpha: Float(assignment["courseColorAlpha"]!)!)
                    try! realm.write {
                        realm.add(a)
                    }
                case "delete":
                    let predicate = NSPredicate(format: "title = %@", assignment["title"]!)
                    let a = realm.objects(AssignmentEnhanced.self).filter(predicate)
                    try! realm.write {
                        realm.delete(a)
                    }
                default:
                    let predicate = NSPredicate(format: "title = %@", message)
                    let a = realm.objects(AssignmentEnhanced.self).filter(predicate)[0]
                    try! realm.write {
                        a.title = assignment["title"]!
                        a.note = assignment["note"]!
                        a.priority = assignment["priority"]!
                        a.date = assignment["date"]!
                        a.courseName = assignment["courseName"]!
                        a.complete = assignment["complete"]!
                        a.courseColorRed = Float(assignment["courseColorRed"]!)!
                        a.courseColorGreen = Float(assignment["courseColorGreen"]!)!
                        a.courseColorBlue = Float(assignment["courseColorBlue"]!)!
                        a.courseColorAlpha = Float(assignment["courseColorAlpha"]!)!
                    }
            }
        }
    }
    
    func sendAssignment(message: String, assignment: AssignmentEnhanced) {
        prepDataAssignment(message: message, assignment: assignment)
        do {
            try self.watchSession?.updateApplicationContext(assignmentsiPhone)
        } catch {
            print("Error sending data to iPhone!")
        }
    }
    
    private func prepDataAssignment(message: String, assignment: AssignmentEnhanced) {
        assignmentsiPhone = [String: [String: String]]()
        
        assignmentsiPhone[message] = ["complete": "true"]
    }
    
    func sendAssistance() {
        assistanceiPhone["assistance"] = ["assistance" : "true"]
        do {
            try self.watchSession?.updateApplicationContext(assistanceiPhone)
        } catch {
            print("Error sending data to iPhone!")
        }
    }
    
    // MARK: - Watch Session
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session activation did complete")
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        print("watch received app context")
        storeData(data: applicationContext)
    }
}
