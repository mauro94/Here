//
//  InterfaceControllerHere.swift
//  Here Watch Extension
//
//  Created by Mauro Amarante Esparza on 4/2/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceControllerHere: WKInterfaceController {
    // MARK: - Outlets
    @IBOutlet var btHere: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        super.becomeCurrentPage()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}
