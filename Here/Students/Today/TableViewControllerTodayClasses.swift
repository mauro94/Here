//
//  TableViewControllerTodayClasses.swift
//  Here
//
//  Created by Mauro on 4/20/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewControllerTodayClasses: UITableViewController {
    // MARK: Outlets
    @IBOutlet var vNoClass: UIView!
    
    // MARK: - Variables
    let realm = try! Realm()
    var classes: Results<Class>!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Get data
        let today = Calendar.current.component(.weekday, from: Date())
        switch today {
        case 1:
            classes = realm.objects(Class.self).filter("sunday = true")
        case 2:
            classes = realm.objects(Class.self).filter("monday = true")
        case 3:
            classes = realm.objects(Class.self).filter("tuesday = true")
        case 4:
            classes = realm.objects(Class.self).filter("wednesday = true")
        case 5:
            classes = realm.objects(Class.self).filter("thursday = true")
        case 6:
            classes = realm.objects(Class.self).filter("friday = true")
        default:
            classes = realm.objects(Class.self).filter("saturday = true")
        }
        
        classes = classes.sorted(byKeyPath: "hour", ascending: true)
        
        // Tableview
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        
        if classes.count > 0 {
            tableView.separatorStyle = .singleLine
            numOfSections = 1
            tableView.backgroundView = nil
            tableView.isScrollEnabled = true
        }
        else {
            tableView.backgroundView = vNoClass
            tableView.separatorStyle = .none
            tableView.isScrollEnabled = false
        }
        return numOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellClass", for: indexPath) as! TableViewCellTodayClass
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.lbClass.text = classes[indexPath.row].course?.name
        cell.lbTime.text = classes[indexPath.row].hour + ":" + classes[indexPath.row].minute
        cell.lbClassRoom.text = classes[indexPath.row].building + "-" + classes[indexPath.row].room
        
        if classes.count == 1 {
            cell.bOne = true
            return cell
        }
        
        if indexPath.row == 0 {
            cell.bFirst = true
        }
        if indexPath.row == classes.count-1 {
            cell.bLast = true
        }


        return cell
    }
 
}
