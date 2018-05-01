//
//  TableViewControllerTodayAssignments.swift
//  Here
//
//  Created by Mauro on 4/21/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewControllerTodayAssignments: UITableViewController {
    
    // MARK: Outlets
    @IBOutlet var vNoAssignment: UIView!
    
    // MARK: Variables
    var data: Results<Assignment>!
    var dataType: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let realm = try! Realm()
        
        if dataType == 1 {
            let start = Calendar.current.startOfDay(for: Date())
            let end: Date = {
                let components = DateComponents(day: 1, second: -1)
                return Calendar.current.date(byAdding: components, to: start)!
            }()
            
            data = realm.objects(Assignment.self).filter("date BETWEEN %@", [start, end])
            data = data.sorted(byKeyPath: "date", ascending: true)
            tableView.reloadData()
        }
        
        else if dataType == 2 {
            let start: Date = {
                let components = DateComponents(day: 1, second: -1)
                return Calendar.current.date(byAdding: components, to: Calendar.current.startOfDay(for: Date()))!
            }()
            let end: Date = {
                let components = DateComponents(day: 2, second: -1)
                return Calendar.current.date(byAdding: components, to: start)!
            }()
            
            data = realm.objects(Assignment.self).filter("date BETWEEN %@", [start, end])
            data = data.sorted(byKeyPath: "date", ascending: true)
            tableView.reloadData()
        }
        
        else {
            let start: Date = {
                let components = DateComponents(day: 2, second: -1)
                return Calendar.current.date(byAdding: components, to: Calendar.current.startOfDay(for: Date()))!
            }()
            let end: Date = {
                let components = DateComponents(day: 3, second: -1)
                return Calendar.current.date(byAdding: components, to: start)!
            }()
            
            data = realm.objects(Assignment.self).filter("date BETWEEN %@", [start, end])
            data = data.sorted(byKeyPath: "date", ascending: true)
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        
        if data.count > 0 {
            tableView.separatorStyle = .singleLine
            numOfSections = 1
            tableView.backgroundView = nil
            tableView.isScrollEnabled = true
        }
        else {
            tableView.backgroundView = vNoAssignment
            tableView.separatorStyle = .none
            tableView.isScrollEnabled = false
        }
        return numOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCellAssignmentDue
         cell.selectionStyle = UITableViewCellSelectionStyle.none
         cell.lbTitle.text = data[indexPath.row].title
         cell.lbCourse.text = data[indexPath.row].classCourse?.course?.name
         
         let red = CGFloat((data[indexPath.row].classCourse?.red)!)
         let green = CGFloat((data[indexPath.row].classCourse?.green)!)
         let blue = CGFloat((data[indexPath.row].classCourse?.blue)!)
         let alpha = CGFloat((data[indexPath.row].classCourse?.alpha)!)
         
         let circle = UIBezierPath(arcCenter: CGPoint(x: 10,y: 10), radius: CGFloat(5), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
         
         let shapeLayer = CAShapeLayer()
         shapeLayer.path = circle.cgPath
         
         shapeLayer.fillColor = UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor
         
         cell.vColor.layer.addSublayer(shapeLayer)
         
         return cell
    }
}
