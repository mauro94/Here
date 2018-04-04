//
//  ViewControllerHere.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 4/3/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit

class ViewControllerHere: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var btAbsence: UIButton!
    @IBOutlet weak var btAssignment: UIButton!
    @IBOutlet weak var lbTimeRemaining: UILabel!
    @IBOutlet weak var btHere: UIButton!
    @IBOutlet weak var lbClass: UILabel!
    @IBOutlet weak var lbRoom: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    
    // MARK: - Variables
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Temp data
        btAbsence.setTitle("6", for: .normal)
        lbTimeRemaining.text = "22 minutes"
        lbClass.text = "Sistemas Inteligentes"
        lbRoom.text = "A3-303"
        lbTime.text = "12:00pm"
        
        // Draw buttons
        btAbsence.frame = CGRect(x: btAbsence.frame.origin.x, y: btAbsence.frame.origin.y, width: btAbsence.frame.width, height: btAbsence.frame.height)
        btAbsence.layer.cornerRadius = 0.5 * btAbsence.bounds.size.width
        btAbsence.clipsToBounds = true
        btAbsence.backgroundColor = UIColor(red: 161/255, green: 239/255, blue: 139/255, alpha: 1)
        
        btAssignment.frame = CGRect(x: btAssignment.frame.origin.x, y: btAssignment.frame.origin.y, width: btAssignment.frame.width, height: btAssignment.frame.height)
        btAssignment.layer.cornerRadius = 0.5 * btAssignment.bounds.size.width
        btAssignment.clipsToBounds = true
        btAssignment.backgroundColor = UIColor(red: 52/255, green: 58/255, blue: 64/255, alpha: 1)
        
        btHere.frame = CGRect(x: btHere.frame.origin.x, y: btHere.frame.origin.y, width: btHere.frame.width, height: btHere.frame.height)
        btHere.layer.cornerRadius = 0.5 * btHere.bounds.size.width
        btHere.clipsToBounds = true
        btHere.backgroundColor = UIColor(red: 52/255, green: 58/255, blue: 64/255, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func here(_ sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM/dd HH:mm"
        
        let currentTime = formatter.string(from: Date())
        
        let alert = UIAlertController(title: "Success", message: "Assistance has been registered \n\(currentTime)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
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
