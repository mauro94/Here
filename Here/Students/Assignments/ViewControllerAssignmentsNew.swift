//
//  ViewControllerAssignmentsNew.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 2/15/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class ViewControllerAssignmentsNew: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - Outlets
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var dpDate: UIDatePicker!
    @IBOutlet weak var sgPriority: UISegmentedControl!
    @IBOutlet weak var pCourse: UIPickerView!
    @IBOutlet weak var tvNotes: UITextView!
    @IBOutlet weak var btCancel: UIButton!
    @IBOutlet weak var btSave: UIButton!
    @IBOutlet weak var scScroll: UIScrollView!
    
    // MARK: - Variables
    let realm = try! Realm()
    var courses: Results<Course>!
    var coursesArray = [Course]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Color
        let darkColor = UIColor(red: 52/255, green: 58/255, blue: 64/255, alpha: 1)
        
        // Status bar color
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = darkColor
        view.addSubview(statusBarView)
        
        // Textfield design
        tfTitle.layer.cornerRadius = 8.0
        tfTitle.layer.borderWidth = 1
        tfTitle.layer.borderColor = UIColor.lightGray.cgColor
        
        sgPriority.layer.cornerRadius = 8.0
        
        tvNotes.layer.cornerRadius = 8.0
        tvNotes.layer.borderWidth = 1
        tvNotes.layer.borderColor = UIColor.lightGray.cgColor
        
        // Button design
        btSave.layer.cornerRadius = 8.0
        btCancel.layer.cornerRadius = 8.0
        
        // Select correct option in segmented
        sgPriority.selectedSegmentIndex = 1
        
        // Prep course picker
        self.pCourse.dataSource = self
        self.pCourse.delegate = self
        courses = realm.objects(Course.self)
        coursesArray = Array(courses)
        
        scScroll.keyboardDismissMode = .onDrag
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
    
    @IBAction func save(_ sender: UIButton) {
        // Verify fields have text
        if tfTitle.text != "" {
            // Define selected course
            let selectedCourseIndex = pCourse.selectedRow(inComponent: 0)
            
            // Save in realm
            let assignment = Assignment(title: tfTitle.text!, note: tvNotes.text, priority: sgPriority.selectedSegmentIndex, date: dpDate.date, course: coursesArray[selectedCourseIndex])
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
