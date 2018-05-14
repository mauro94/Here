//
//  InterfaceControllerAssignemt.swift
//  Here Watch Extension
//
//  Created by Mauro Amarante Esparza on 4/9/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import Foundation
import WatchKit
import RealmSwift

class InterfaceControllerAssignemt: WKInterfaceController {
    // MARK: - Outlets
    @IBOutlet var lbTitle: WKInterfaceLabel!
    @IBOutlet var lbCourseName: WKInterfaceLabel!
    @IBOutlet var lbNote: WKInterfaceLabel!
    @IBOutlet var vColor: WKInterfaceGroup!
    
    // MARK: - Variables
    let realm = try! Realm()
    var assignment: AssignmentEnhanced!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let assignment = context as? AssignmentEnhanced {
            self.assignment = assignment
        }
        
        lbTitle.setText(assignment.title)
        lbCourseName.setText(assignment.courseName)
        if assignment.note == "description" {
            lbNote.setText(assignment.note)
        }
        else {
            lbNote.setText("")
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func completeAssignment() {
        // Watch
        let extensionDelegate = WKExtension.shared().delegate as! ExtensionDelegate
        let watchConnectionHelper = extensionDelegate.watchConnectionHelper
        watchConnectionHelper.sendAssignment(message:assignment.title, assignment: assignment)
        
        let a = realm.objects(AssignmentEnhanced.self).filter("title = %@", assignment.title)[0]
        try! realm.write {
            a.complete = "true"
        }
        
        self.dismiss()
    }
}
