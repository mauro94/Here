//
//  TableViewControllerAssignments.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 2/15/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewControllerAssignments: UITableViewController {
    // MARK: - Variables
    let realm = try! Realm()
    var assignments: Results<Assignment>!

    // MARK: - Outlets
    @IBOutlet var vNoAssignments: UIView!
    @IBOutlet weak var btNewAssignment: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true

        // Get data
        assignments = realm.objects(Assignment.self)
        assignments = assignments!.sorted(byKeyPath: "date", ascending: true)
        
        // Button style
        btNewAssignment.layer.cornerRadius = 8.0
    
        // Remove navbar shadow
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func unwindNewCancel(unwindSegue: UIStoryboardSegue) {
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
        
        let red = CGFloat((assignments[indexPath.row].course?.red)!)
        let green = CGFloat((assignments[indexPath.row].course?.green)!)
        let blue = CGFloat((assignments[indexPath.row].course?.blue)!)
        let alpha = CGFloat((assignments[indexPath.row].course?.alpha)!)
        
        let circle = UIBezierPath(arcCenter: CGPoint(x: 4,y: 4), radius: CGFloat(6), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circle.cgPath
        
        shapeLayer.fillColor = UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor
        
        cell.lbTitle.text = assignments[indexPath.row].title
        cell.lbDate.text = formatter.string(from: assignments[indexPath.row].date!)
        cell.lbCourse.text = assignments[indexPath.row].course?.name
        cell.vColor.layer.addSublayer(shapeLayer)
        
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
    
    @IBAction func unwindEdit(unwindSegue: UIStoryboardSegue) {
        // Do nothing
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "viewAssignment") {
            let view = segue.destination as! ViewControllerAssignmentsView
            let indexPath = tableView.indexPathForSelectedRow!
            view.assignment = assignments[indexPath.row]
        }
    }
}
