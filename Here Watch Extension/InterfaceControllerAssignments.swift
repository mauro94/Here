//
//  InterfaceControllerAssignments.swift
//  Here Watch Extension
//
//  Created by Mauro Amarante Esparza on 4/4/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import Foundation
import WatchKit
import RealmSwift

class InterfaceControllerAssignments: WKInterfaceController {
    // MARK: - Outlets
    @IBOutlet var tbAssignments: WKInterfaceTable!
    
    // MARK: - Variables
    let realm = try! Realm()
    var assignments: Results<AssignmentEnhanced>!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        assignments = realm.objects(AssignmentEnhanced.self)
        loadTableData()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func loadTableData() {
        tbAssignments.setNumberOfRows(assignments.count, withRowType: "TableRowControllerAssignment")
        
        for i in 0..<assignments.count {
            let row = tbAssignments.rowController(at: i) as! TableRowControllerAssignment
            let color = UIColor(red: CGFloat(assignments[i].courseColorRed),
                                green: CGFloat(assignments[i].courseColorGreen),
                                blue: CGFloat(assignments[i].courseColorBlue),
                                alpha: CGFloat(assignments[i].courseColorAlpha))
            
            row.lbName.setText(assignments[i].title)
            row.lbDate.setText(assignments[i].date)
            row.grColor.setBackgroundColor(color)
        }
    }
}
