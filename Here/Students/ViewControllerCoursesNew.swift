//
//  ViewControllerCoursesNew.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 2/15/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class ViewControllerCoursesNew: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfGroup: UITextField!
    @IBOutlet weak var tfLocationBuilding: UITextField!
    @IBOutlet weak var tfLocationRoom: UITextField!
    @IBOutlet weak var btSave: UIButton!
    @IBOutlet weak var btCancel: UIButton!
    
    // MARK: - Variables
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Color
        let darkColor = UIColor(red: 52/255, green: 58/255, blue: 64/255, alpha: 1)
        
        // Status bar color
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = darkColor
        view.addSubview(statusBarView)
        
        // Textfield design
        tfName.layer.cornerRadius = 8.0
        tfName.layer.borderWidth = 1
        tfName.layer.borderColor = UIColor.lightGray.cgColor
        
        tfGroup.layer.cornerRadius = 8.0
        tfGroup.layer.borderWidth = 1
        tfGroup.layer.borderColor = UIColor.lightGray.cgColor
        
        tfLocationBuilding.layer.cornerRadius = 8.0
        tfLocationBuilding.layer.borderWidth = 1
        tfLocationBuilding.layer.borderColor = UIColor.lightGray.cgColor
        
        tfLocationRoom.layer.cornerRadius = 8.0
        tfLocationRoom.layer.borderWidth = 1
        tfLocationRoom.layer.borderColor = UIColor.lightGray.cgColor
        
        // Button design
        btSave.layer.cornerRadius = 8.0
        btCancel.layer.cornerRadius = 8.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func quitarTeclado() {
        view.endEditing(true)
    }
    
    @IBAction func saveCourse(_ sender: UIButton) {
        // Verify fields have text
        if tfName.text != "" && tfGroup.text != "" && tfLocationBuilding.text != "" && tfLocationRoom.text != "" {
            // Save in realm
            let course = Course(name: tfName.text!, group: tfGroup.text!, locationBuilding: tfLocationBuilding.text!, locationRoom: tfLocationRoom.text!)
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
