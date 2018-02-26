//
//  TableViewControllerCourses.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 2/15/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class CourseTableViewCell: UITableViewCell {
    // MARK: - Cell Outlets
    @IBOutlet weak var lbCourseTitle: UILabel!
    @IBOutlet weak var vCourseColor: UIView!
}

class TableViewControllerCourses: UITableViewController {
    // MARK: - Outlets
    @IBOutlet var vNoCourse: UIView!
    @IBOutlet weak var btNewCourse: UIButton!
    
    // MARK: - Variables
    let realm = try! Realm()
    var courses: Results<Course>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get data
        courses = realm.objects(Course.self)
        
        // Button design
        btNewCourse.layer.cornerRadius = 8.0
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        // #warning Incomplete implementation, return the number of sections
        var numOfSections: Int = 0
        if courses.count > 1 {
            tableView.separatorStyle = .singleLine
            numOfSections = 1
            tableView.backgroundView = nil
            tableView.isScrollEnabled = true
        }
        else {
            tableView.backgroundView = vNoCourse
            tableView.separatorStyle = .none
            tableView.isScrollEnabled = false
        }
        return numOfSections    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return courses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! CourseTableViewCell
        cell.accessoryType = .disclosureIndicator
        
        // Circle color
        let circle = UIBezierPath(arcCenter: CGPoint(x: 15,y: 15), radius: CGFloat(8), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circle.cgPath
        
        let red = CGFloat(courses[indexPath.row].red)
        let green = CGFloat(courses[indexPath.row].green)
        let blue = CGFloat(courses[indexPath.row].blue)
        let alpha = CGFloat(courses[indexPath.row].alpha)
        
        shapeLayer.fillColor = UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor
        
        // Data
        cell.lbCourseTitle.text = courses[indexPath.row].name
        cell.vCourseColor.layer.addSublayer(shapeLayer)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 0.0
        }
        
        return 44.0
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "viewCourse") {
            let view = segue.destination as! ViewControllerCoursesView
            let indexPath = tableView.indexPathForSelectedRow!
            view.course = courses[indexPath.row]
        }
    }
    

}
