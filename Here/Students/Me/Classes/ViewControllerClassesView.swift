//
//  ViewControllerClassesView.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 2/15/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class ViewControllerClassesView: UIViewController, UITextFieldDelegate, ChromaColorPickerDelegate {
    // MARK: - Outlets
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfGroup: UITextField!
    @IBOutlet weak var tfBuilding: UITextField!
    @IBOutlet weak var tfRoom: UITextField!
    @IBOutlet weak var btSaveChanges: UIButton!
    @IBOutlet weak var vColor: UIView!
    
    // MARK: - Variables
    var classRealm: Class!
    let realm = try! Realm()
    var colorPicker: ChromaColorPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title
        self.title = classRealm.course?.name
        
        // Button design
        btSaveChanges.layer.cornerRadius = 8.0
        
        // Configure text fields
        tfName.delegate = self
        tfGroup.delegate = self
        tfBuilding.delegate = self
        tfRoom.delegate = self
        
        // Get data
        tfName.text = classRealm.course?.name
        tfGroup.text = classRealm.group
        tfBuilding.text = classRealm.building
        tfRoom.text = classRealm.room
        
        // Color view
        let lengthSide = self.view.frame.width
        
        colorPicker = ChromaColorPicker(frame:CGRect(x: 0, y: 0, width: lengthSide-50, height: lengthSide-50))
        colorPicker.delegate = self
        colorPicker.hexLabel.isHidden = true
        colorPicker.stroke = 3
        
        let red = CGFloat(classRealm.red)
        let green = CGFloat(classRealm.green)
        let blue = CGFloat(classRealm.blue)
        let alpha = CGFloat(classRealm.alpha)

        colorPicker.adjustToColor(UIColor(red: red, green: green, blue: blue, alpha: alpha))
        
        vColor.addSubview(colorPicker)
        
        // Delete button
        if classRealm.beaconUUID == "" {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteClass))
            
            tfName.isEnabled = true
            tfGroup.isEnabled = true
            tfBuilding.isEnabled = true
            tfRoom.isEnabled = true
            
            tfName.alpha = 1
            tfGroup.alpha = 1
            tfBuilding.alpha = 1
            tfRoom.alpha = 1
            
            btSaveChanges.setTitle("Save Changes", for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
                classRealm.course?.name = tfName.text!
                classRealm.group = tfGroup.text!
                classRealm.building = tfBuilding.text!
                classRealm.room = tfRoom.text!
                classRealm.red = Float(fRed)
                classRealm.green = Float(fGreen)
                classRealm.blue = Float(fBlue)
                classRealm.alpha = Float(fAlpha)
            }
            self.navigationController?.popViewController(animated: true)
        }
        else {
            // Alert fields are empty
            let alert = UIAlertController(title: "Missing Data", message: "There are some empty data fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func deleteClass(_ sender: UIButton) {
        let alert = UIAlertController(title: "Delete Course", message: "Are you sure you want to delete this course?", preferredStyle: .alert)
        let clearAction = UIAlertAction(title: "Delete", style: .destructive) { (alert: UIAlertAction!) -> Void in
            try! self.realm.write {
                self.realm.delete(self.classRealm.course!)
                self.realm.delete(self.classRealm)
            }
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (alert: UIAlertAction!) -> Void in
        }
        
        alert.addAction(clearAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion:nil)
    }
}
