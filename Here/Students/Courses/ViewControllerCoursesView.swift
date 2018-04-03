//
//  ViewControllerCoursesView.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 2/15/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class ViewControllerCoursesView: UIViewController, UITextFieldDelegate, ChromaColorPickerDelegate {
    // MARK: - Outlets
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfGroup: UITextField!
    @IBOutlet weak var tfBuilding: UITextField!
    @IBOutlet weak var tfRoom: UITextField!
    @IBOutlet weak var btSaveChanges: UIButton!
    @IBOutlet weak var vColor: UIView!
    
    // MARK: - Variables
    var course: Course!
    let realm = try! Realm()
    var colorPicker: ChromaColorPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Nav bar
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // Title
        self.title = course.name
        
        // Button design
        btSaveChanges.layer.cornerRadius = 8.0
        
        // Configure text fields
        tfName.delegate = self
        tfGroup.delegate = self
        tfBuilding.delegate = self
        tfRoom.delegate = self
        
        // Get data
        tfName.text = course.name
        tfGroup.text = course.group
        tfBuilding.text = course.building
        tfRoom.text = course.room
        
        // Color view
        let lengthSide = self.view.frame.width
        
        colorPicker = ChromaColorPicker(frame:CGRect(x: 0, y: 0, width: lengthSide-50, height: lengthSide-50))
        colorPicker.delegate = self
        colorPicker.hexLabel.isHidden = true
        colorPicker.stroke = 3
        
        let red = CGFloat(course.red)
        let green = CGFloat(course.green)
        let blue = CGFloat(course.blue)
        let alpha = CGFloat(course.alpha)

        colorPicker.adjustToColor(UIColor(red: red, green: green, blue: blue, alpha: alpha))
        
        vColor.addSubview(colorPicker)
        
        // Delete button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteCourse))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func quitarTeclado() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        // Nothing
    }
    
    @IBAction func saveChanges(_ sender: UIButton) {
        // Verify fields have text
        if tfName.text != "" && tfGroup.text != "" && tfBuilding.text != "" && tfRoom.text != "" {
            // Get selected color
            var fRed: CGFloat = 0
            var fGreen: CGFloat = 0
            var fBlue: CGFloat = 0
            var fAlpha: CGFloat = 0
            
            colorPicker.currentColor.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha)
            
            // Update in realm
            try! realm.write {
                course.name = tfName.text!
                course.group = tfGroup.text!
                course.building = tfBuilding.text!
                course.room = tfRoom.text!
                course.red = Float(fRed)
                course.green = Float(fGreen)
                course.blue = Float(fBlue)
                course.alpha = Float(fAlpha)
            }
            navigationController?.popToRootViewController(animated: true)
        }
        else {
            // Alert fields are empty
            let alert = UIAlertController(title: "Missing Data", message: "There are some empty data fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func deleteCourse(_ sender: UIButton) {
        let alert = UIAlertController(title: "Delete Course", message: "Are you sure you want to delete this course?", preferredStyle: .alert)
        let clearAction = UIAlertAction(title: "Delete", style: .destructive) { (alert: UIAlertAction!) -> Void in
            try! self.realm.write {
                self.realm.delete(self.course)
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
