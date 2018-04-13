//
//  ViewControllerAssignmentsDue.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 4/12/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class ViewControllerAssignmentsDue: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Outlets
    @IBOutlet weak var tbAssignments: UITableView!
    
    // MARK: - Variables
    let realm = try! Realm()
    var assignments: Results<Assignment>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get data
        let todayStart = Calendar.current.startOfDay(for: Date())
        let todayEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: todayStart)!
        }()
        assignments = realm.objects(Assignment.self).filter("date BETWEEN %@", [todayStart, todayEnd])
        assignments = assignments!.sorted(byKeyPath: "date", ascending: true)

        // Tableview
        tbAssignments.delegate = self
        tbAssignments.dataSource = self
        tbAssignments.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignments.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCellAssignmentDue
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.lbTitle.text = assignments[indexPath.row].title
        cell.lbCourse.text = assignments[indexPath.row].classCourse?.course?.name
        
        let red = CGFloat((assignments[indexPath.row].classCourse?.red)!)
        let green = CGFloat((assignments[indexPath.row].classCourse?.green)!)
        let blue = CGFloat((assignments[indexPath.row].classCourse?.blue)!)
        let alpha = CGFloat((assignments[indexPath.row].classCourse?.alpha)!)
        
        let circle = UIBezierPath(arcCenter: CGPoint(x: 10,y: 10), radius: CGFloat(5), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circle.cgPath
        
        shapeLayer.fillColor = UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor
        
        cell.vColor.layer.addSublayer(shapeLayer)
        
        return cell
    }
}
