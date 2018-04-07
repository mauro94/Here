//
//  ViewControllerHereNotifications.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 4/7/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import UserNotifications

class ViewControllerHereNotifications: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var btNotifications: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Button
        btNotifications.frame = CGRect(x: btNotifications.frame.origin.x, y: btNotifications.frame.origin.y, width: btNotifications.frame.width, height: btNotifications.frame.height)
        btNotifications.layer.cornerRadius = 0.5 * btNotifications.bounds.size.width
        btNotifications.clipsToBounds = true
        btNotifications.backgroundColor = UIColor(red: 52/255, green: 58/255, blue: 64/255, alpha: 1)
        btNotifications.titleLabel?.textAlignment = NSTextAlignment.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func enableNotifications(_ sender: UIButton) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {
            granted, error  in
            DispatchQueue.main.async(){
                    self.performSegue(withIdentifier: "device", sender: self)
                }
        })
    }
}
