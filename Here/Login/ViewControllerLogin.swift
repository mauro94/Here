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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func unwindAbout(unwindSegue: UIStoryboardSegue) {
        // Do nothing
    }
    
    @IBAction func login(_ sender: UIButton) {
        if (tfUser.text == "" || tfPassword.text == "") {
            alertOk(title: "Error", message: "Fields cannot be empty", vc: self)
        }
        
        //print (loginAttempt(user: "A01191903", password: "12344321"))
    }
}

