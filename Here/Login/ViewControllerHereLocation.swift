//
//  ViewControllerHereLocation.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 4/7/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit
import CoreLocation

class ViewControllerHereLocation: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var btLocation: UIButton!
    
    // MARK: - Variables
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Button
        btLocation.frame = CGRect(x: btLocation.frame.origin.x, y: btLocation.frame.origin.y, width: btLocation.frame.width, height: btLocation.frame.height)
        btLocation.layer.cornerRadius = 0.5 * btLocation.bounds.size.width
        btLocation.clipsToBounds = true
        btLocation.backgroundColor = UIColor(red: 52/255, green: 58/255, blue: 64/255, alpha: 1)
        btLocation.titleLabel?.textAlignment = NSTextAlignment.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func enableLocation(_ sender: UIButton) {
        locationManager.requestAlwaysAuthorization()
    }
}
