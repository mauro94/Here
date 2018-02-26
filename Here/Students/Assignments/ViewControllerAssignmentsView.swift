//
//  ViewControllerAssignmentsView.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 2/15/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class ViewControllerAssignmentsView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - Outlets
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var dpDate: UIDatePicker!
    @IBOutlet weak var sgPriority: UISegmentedControl!
    @IBOutlet weak var pCourse: UIPickerView!
    @IBOutlet weak var tvNotes: UITextView!
    @IBOutlet weak var btSaveChanges: UIButton!
    @IBOutlet weak var scScroll: UIScrollView!
    @IBOutlet weak var btDelete: UIButton!
    
    // MARK: - Variables
    var assignment: Assignment!
    let realm = try! Realm()
    var courses: Results<Course>!
    var coursesArray = [Course]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = assignment.title
        
        // Textfield design
        tfTitle.layer.cornerRadius = 8.0
        tfTitle.layer.borderWidth = 1
        tfTitle.layer.borderColor = UIColor.lightGray.cgColor
        
        sgPriority.layer.cornerRadius = 8.0
        
        tvNotes.layer.cornerRadius = 8.0
        tvNotes.layer.borderWidth = 1
        tvNotes.layer.borderColor = UIColor.lightGray.cgColor
        
        // Button design
        btSaveChanges.layer.cornerRadius = 8.0
        btDelete.layer.cornerRadius = 8.0

        // Select correct option in segmented
        sgPriority.selectedSegmentIndex = 1
        
        // Prep course picker
        self.pCourse.dataSource = self
        self.pCourse.delegate = self
        courses = realm.objects(Course.self)
        coursesArray = Array(courses)
        
        scScroll.keyboardDismissMode = .onDrag
        
        // Display data
        tfTitle.text = assignment.title
        tvNotes.text = assignment.note
        dpDate.date = assignment.date!
        sgPriority.selectedSegmentIndex = assignment.priority
        let courseIndex = courses.index(of: assignment.course!)
        pCourse.selectRow(courseIndex!, inComponent: 0, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return coursesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return coursesArray[row].name
    }

    
    @IBAction func saveChanges(_ sender: UIButton) {
        // Verify fields have text
        if tfTitle.text != ""  {
            // Define selected course
            let selectedCourseIndex = pCourse.selectedRow(inComponent: 0)

            // Update in realm
            try! realm.write {
                assignment.title = tfTitle.text!
                assignment.note = tvNotes.text
                assignment.priority = sgPriority.selectedSegmentIndex
                assignment.date = dpDate.date
                assignment.course = coursesArray[selectedCourseIndex]
            }
            navigationController?.popToRootViewController(animated: true)
        }
        else {
            // Alert fields are empty
            let alert = UIAlertController(title: "Missing Title", message: "Define a title for this assignment", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func deleteAssignment(_ sender: UIButton) {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
