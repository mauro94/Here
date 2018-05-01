//
//  ViewControllerAssignmentsDue.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 4/12/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class ViewControllerAssignmentsDue: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let realm = try! Realm()
        let view = segue.destination as! TableViewControllerTodayAssignments
        var assignments = realm.objects(Assignment.self)
        
        if segue.identifier == "today" {
            let start = Calendar.current.startOfDay(for: Date())
            let end: Date = {
                let components = DateComponents(day: 0, second: -1)
                return Calendar.current.date(byAdding: components, to: start)!
            }()
            assignments = assignments.filter("date BETWEEN %@", [start, end])
            assignments = assignments.sorted(byKeyPath: "date", ascending: true)
            
            view.data = assignments
            view.dataType = 1
        }
        
        else if segue.identifier == "tomorrow" {
            let start: Date = {
                let components = DateComponents(day: 1, second: -1)
                return Calendar.current.date(byAdding: components, to: Calendar.current.startOfDay(for: Date()))!
            }()
            let end: Date = {
                let components = DateComponents(day: 1, second: -1)
                return Calendar.current.date(byAdding: components, to: start)!
            }()
            assignments = assignments.filter("date BETWEEN %@", [start, end])
            assignments = assignments.sorted(byKeyPath: "date", ascending: true)
            
            view.data = assignments
            view.dataType = 2
        }
        
        else {
            let start: Date = {
                let components = DateComponents(day: 2, second: -1)
                return Calendar.current.date(byAdding: components, to: Calendar.current.startOfDay(for: Date()))!
            }()
            let end: Date = {
                let components = DateComponents(day: 1, second: -1)
                return Calendar.current.date(byAdding: components, to: start)!
            }()
            assignments = assignments.filter("date BETWEEN %@", [start, end])
            assignments = assignments.sorted(byKeyPath: "date", ascending: true)
            
            view.data = assignments
            view.dataType = 3
        }
    }
}
