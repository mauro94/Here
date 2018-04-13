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
    @IBOutlet weak var btLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Button design
        btLogin.layer.cornerRadius = 8.0
        
        // Keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func unwindAbout(unwindSegue: UIStoryboardSegue) {
        // Do nothing
    }
    
    @IBAction func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func login(_ sender: UIButton) {
        if (tfUser.text == "" || tfPassword.text == "") {
            alertOk(title: "Error", message: "Fields cannot be empty", vc: self)
        }
        
        //print (loginAttempt(user: "A01191903", password: "12344321"))
    }
    
    // MARK: - Keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= 130
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += 130
        }
    }
}

