//
//  ViewControllerAssignmentsView.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 2/15/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class ViewControllerAssignmentsView: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource   {
    
    // MARK: - Outlets
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tvNotes: UITextView!
    @IBOutlet weak var btSaveChanges: UIButton!
    @IBOutlet weak var tbFields: UITableView!

    // MARK: - Variables
    var assignment: Assignment!
    let realm = try! Realm()
    var courses: Results<Course>!
    var coursesArray = [Course]()
    var cellExpanded = [Bool]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        self.title = assignment.title
        
        // Button design
        btSaveChanges.layer.cornerRadius = 8.0
        
        // Prep course data
        courses = realm.objects(Course.self)
        coursesArray = Array(courses)
        
        // Textview
        tvNotes.delegate = self
        tvNotes.text = "Description"
        tvNotes.textColor = .lightGray
        
        // Tableview
        tbFields.delegate = self
        tbFields.dataSource = self
        tbFields.tableFooterView = UIView()
        
        // Expanded cell prep
        cellExpanded.append(false)
        cellExpanded.append(false)
        cellExpanded.append(false)
        
        // Display data
        tfTitle.text = assignment.title
        tvNotes.text = assignment.note
        
        let cellCourse = tbFields.cellForRow(at: IndexPath(row: 0, section: 0)) as! TableViewCellCourseAssignment
        let cellDate = tbFields.cellForRow(at: IndexPath(row: 1, section: 0)) as! TableViewCellDate
        let cellPriority = tbFields.cellForRow(at: IndexPath(row: 2, section: 0)) as! TableViewCellPriority
        
        let courseIndex = courses.index(of: assignment.course!)
        cellCourse.setCourse(courseIndex: courseIndex!)
        cellDate.setDate(date: assignment.date!)
        cellPriority.setPriority(priority: assignment.priority)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        // Size modifications
        if self.view.frame.width <= 320 {
            let cellPriority = tbFields.cellForRow(at: IndexPath(row: 2, section: 0)) as! TableViewCellPriority
            cellPriority.changeButtonText()
            
            for constraint in tvNotes.constraints {
                if constraint.identifier == "noteHeight" {
                    constraint.constant = 50
                }
            }
            tvNotes.layoutIfNeeded()
            
        }
    }
    
    // MARK: - Text view
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "Description") {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "") {
            textView.text = "Description"
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
    
    // MARK: - Actions
    @IBAction func saveChanges(_ sender: UIButton) {
        // Verify fields have text
        if tfTitle.text != "" {
            let cellCourse = tbFields.cellForRow(at: IndexPath(row: 0, section: 0)) as! TableViewCellCourseAssignment
            let cellDate = tbFields.cellForRow(at: IndexPath(row: 1, section: 0)) as! TableViewCellDate
            let cellPriority = tbFields.cellForRow(at: IndexPath(row: 2, section: 0)) as! TableViewCellPriority
            
            // Define selected course
            let pvCourse = cellCourse.pvCourses!
            let selectedCourseIndex = pvCourse.selectedRow(inComponent: 0)
            
            // Define selected date
            let date = cellDate.date
            
            // Define selected priority
            let priority = cellPriority.selectedPriority
            
            // Save in realm
            let assignment = Assignment(title: tfTitle.text!, note: tvNotes.text, priority: priority, date: date, course: coursesArray[selectedCourseIndex])
            try! realm.write {
                realm.add(assignment)
            }
            self.dismiss(animated: true, completion: nil)
        }
        else {
            // Alert fields are empty
            let alert = UIAlertController(title: "Missing Title", message: "Define a title for this assignment", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func deleteAssignment(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Delete Assignment", message: "Are you sure you want to delete this assignment?", preferredStyle: .alert)
        let clearAction = UIAlertAction(title: "Delete", style: .destructive) { (alert: UIAlertAction!) -> Void in
            try! self.realm.write {
                self.realm.delete(self.assignment)
            }
            self.navigationController?.popToRootViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (alert: UIAlertAction!) -> Void in
        }
        
        alert.addAction(clearAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion:nil)
    }
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0...2 {
            cellExpanded[i] = false
        }
        
        if cellExpanded[indexPath.row] {
            cellExpanded[indexPath.row] = false
        }
        else {
            cellExpanded[indexPath.row] = !cellExpanded[indexPath.row]
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cellExpanded[indexPath.row] {
            if indexPath.row == 1 {
                return 220
            }
            if indexPath.row == 2 {
                return 100
            }
            return 200
        }
        else {
            return 44
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "priorityCell", for: indexPath)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
        }
    }

}