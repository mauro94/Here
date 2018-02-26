//
//  ViewControllerCoursesNew.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 2/15/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class ViewControllerCoursesNew: UIViewController, UITextFieldDelegate, ChromaColorPickerDelegate {
    // MARK: - Outlets
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfGroup: UITextField!
    @IBOutlet weak var tfBuilding: UITextField!
    @IBOutlet weak var tfRoom: UITextField!
    @IBOutlet weak var btSave: UIButton!
    @IBOutlet weak var vColor: UIView!
    
    // MARK: - Variables
    let realm = try! Realm()
    var selectedButton: UIButton??
    var colorPicker: ChromaColorPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Color
        let darkColor = UIColor(red: 52/255, green: 58/255, blue: 64/255, alpha: 1)
        
        // Status bar color
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = darkColor
        view.addSubview(statusBarView)
        
        // Button design
        btSave.layer.cornerRadius = 8.0
        
        // Configure text fields
        tfName.delegate = self
        tfGroup.delegate = self
        tfBuilding.delegate = self
        tfRoom.delegate = self
        
        tfName.tag = 0
        tfGroup.tag = 1
        tfBuilding.tag = 2
        tfRoom.tag = 3
        
        // Color view
        let lengthSide = self.view.frame.width-40
        
        colorPicker = ChromaColorPicker(frame:CGRect(x: 0, y: 0, width: lengthSide, height: lengthSide))
        colorPicker.delegate = self
        colorPicker.hexLabel.isHidden = true
        colorPicker.stroke = 3
        
        vColor.addSubview(colorPicker)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func quitarTeclado() {
        view.endEditing(true)
    }
    
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        // Nothing
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    @IBAction func saveCourse(_ sender: UIButton) {
        // Verify fields have text
        if tfName.text != "" && tfGroup.text != "" && tfBuilding.text != "" && tfRoom.text != "" {
            // Get selected color
            var fRed: CGFloat = 0
            var fGreen: CGFloat = 0
            var fBlue: CGFloat = 0
            var fAlpha: CGFloat = 0
            
            colorPicker.currentColor.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha)
            
            // Save in realm
            let course = Course(
                name: tfName.text!,
                group: tfGroup.text!,
                building: tfBuilding.text!,
                room: tfRoom.text!,
                red: Float(fRed),
                green: Float(fGreen),
                blue: Float(fBlue),
                alpha: Float(fAlpha))
            try! realm.write {
                realm.add(course)
            }
            self.dismiss(animated: true, completion: nil)
        }
        else {
            // Alert fields are empty
            let alert = UIAlertController(title: "Missing Data", message: "There are some empty data fields", preferredStyle: .alert)
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
