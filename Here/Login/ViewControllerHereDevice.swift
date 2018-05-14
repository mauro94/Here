//
//  ViewControllerHereDevice.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 4/7/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import RealmSwift

class ViewControllerHereDevice: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var btDevice: UIButton!
    
    // MARK: - Variables
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Button
        btDevice.frame = CGRect(x: btDevice.frame.origin.x, y: btDevice.frame.origin.y, width: btDevice.frame.width, height: btDevice.frame.height)
        btDevice.layer.cornerRadius = 0.5 * btDevice.bounds.size.width
        btDevice.clipsToBounds = true
        btDevice.backgroundColor = UIColor(red: 52/255, green: 58/255, blue: 64/255, alpha: 1)
        btDevice.titleLabel?.textAlignment = NSTextAlignment.center

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func registerDevice(_ sender: UIButton) {
        let identifierForVendor = UIDevice.current.identifierForVendor
        
        let alert = UIAlertController(title: "Register device", message: "Your device will be linked with your account", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {
            granted in
            DispatchQueue.main.async(){
                self.performSegue(withIdentifier: "location", sender: self)
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
        let student = realm.objects(Student.self)[0]
        try! realm.write {
            student.device = (identifierForVendor?.uuidString)!
        }
    }
}
