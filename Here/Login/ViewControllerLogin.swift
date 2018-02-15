//
//  ViewController.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 1/11/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit

class ViewControllerLogin: UIViewController {
    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add border design
        tfUser.layer.cornerRadius = 8.0
        tfUser.layer.borderWidth = 1
        tfUser.layer.borderColor = UIColor.lightGray.cgColor
        
        tfPassword.layer.cornerRadius = 8.0
        tfPassword.layer.borderWidth = 1
        tfPassword.layer.borderColor = UIColor.lightGray.cgColor
        
        // Password textfield
        tfPassword.isSecureTextEntry = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindAbout(unwindSegue: UIStoryboardSegue) {
        // No contiene nada es solo para regresarnos
    }
}

