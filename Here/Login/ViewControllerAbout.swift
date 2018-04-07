//
//  ViewControllerAbout.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 4/7/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit

class ViewControllerAbout: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var btDone: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Button design
        btDone.layer.cornerRadius = 8.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
