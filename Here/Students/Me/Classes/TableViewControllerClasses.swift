//
//  TableViewControllerClasses.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 2/15/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewCellClass: UITableViewCell {
    // MARK: - Cell Outlets
    @IBOutlet weak var lbClassTitle: UILabel!
    @IBOutlet weak var vClassColor: UIView!
}

class TableViewControllerClasses: UITableViewController {
    // MARK: - Outlets
    @IBOutlet var vNoClass: UIView!
    @IBOutlet weak var btNewClass: UIButton!
    
    // MARK: - Variables
    let realm = try! Realm()
    var classes: Results<Class>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get data
        classes = realm.objects(Class.self)
        
        // Button design
        btNewClass.layer.cornerRadius = 8.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func unwindNewCancel(unwindSegue: UIStoryboardSegue) {
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        
        if classes.count > 1 {
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath) as! TableViewCellClass
        cell.accessoryType = .disclosureIndicator
        
        // Circle color
        let circle = UIBezierPath(arcCenter: CGPoint(x: 15,y: 15), radius: CGFloat(8), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circle.cgPath
        
        let red = CGFloat(classes[indexPath.row].red)
        let green = CGFloat(classes[indexPath.row].green)
        let blue = CGFloat(classes[indexPath.row].blue)
        let alpha = CGFloat(classes[indexPath.row].alpha)
        
        shapeLayer.fillColor = UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor
        
        // Data
        cell.lbClassTitle.text = classes[indexPath.row].course?.name
        cell.vClassColor.layer.addSublayer(shapeLayer)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 0.0
        }
        
        return 44.0
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "viewCourse") {
            let view = segue.destination as! ViewControllerClassesView
            let indexPath = tableView.indexPathForSelectedRow!
            view.classRealm = classes[indexPath.row]
        }
    }
    

}
