//
//  TableViewControllerCompletedAssignments.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 4/10/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewControllerCompletedAssignments: UITableViewController {
    // MARK: - Outlets
    @IBOutlet var vNoAssignments: UIView!
    
    // MARK: - Variables
    let realm = try! Realm()
    var assignments: Results<Assignment>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get data
        assignments = realm.objects(Assignment.self).filter("complete = true")
        assignments = assignments!.sorted(byKeyPath: "date", ascending: true)
        
        // Remove navbar shadow
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Get data
        assignments = realm.objects(Assignment.self).filter("complete = true")
        assignments = assignments!.sorted(byKeyPath: "date", ascending: true)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        
        if assignments.count > 0 {
            tableView.separatorStyle = .singleLine
            numOfSections = 1
            tableView.backgroundView = nil
            tableView.isScrollEnabled = true
        }
        else {
            tableView.backgroundView = vNoAssignments
            tableView.separatorStyle = .none
            tableView.isScrollEnabled = false
        }
        return numOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignments.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "assignmentCell", for: indexPath) as! TableViewCellAssignment
        cell.accessoryType = .disclosureIndicator
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM-d"
        
        let red = CGFloat((assignments[indexPath.row].classCourse?.red)!)
        let green = CGFloat((assignments[indexPath.row].classCourse?.green)!)
        let blue = CGFloat((assignments[indexPath.row].classCourse?.blue)!)
        let alpha = CGFloat((assignments[indexPath.row].classCourse?.alpha)!)
        
        let circle = UIBezierPath(arcCenter: CGPoint(x: 20,y: 20), radius: CGFloat(12), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circle.cgPath
        
        shapeLayer.fillColor = UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor
        
        cell.lbTitle.text = assignments[indexPath.row].title
        cell.lbDate.text = "Completed: " + formatter.string(from: assignments[indexPath.row].completeDate!)
        cell.lbCourse.text = assignments[indexPath.row].classCourse?.course?.name
        cell.vColor.layer.addSublayer(shapeLayer)
        
        cell.btComplete.update(update: assignments[indexPath.row].complete)
        cell.vColor.layer.addSublayer(cell.btComplete.layer)
        
        cell.assignment = assignments[indexPath.row]
        
        switch assignments[indexPath.row].priority {
        case "Low Priority":
            cell.lbTitle.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.thin)
        case "Normal Priority":
            cell.lbTitle.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.regular)
        default:
            cell.lbTitle.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.semibold)
        }
        
        return cell
    }
    
    // MARK: - Navigation    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "viewAssignment") {
            let view = segue.destination as! ViewControllerAssignmentsView
            let indexPath = tableView.indexPathForSelectedRow!
            view.assignment = assignments[indexPath.row]
            view.disableSave = false
        }
    }
}
