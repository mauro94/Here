//
//  Helper.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 3/27/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import Foundation
import UIKit

struct User: Codable {
    var id: String
    var name: String
    var last_name: String
    var student_id: String
    var password: String
    var device_id: String
    var degree: String
}


func attemptLogin(user: String, password: String) -> Bool {
    let urlString = "https://5ab9cf79d9ac5c001434ecbd.mockapi.io/users"
    var approved = false
    
    guard let url = URL(string: urlString) else { return false }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print(error!.localizedDescription)
        }
        
        guard let data = data else { return }

        do {
            let userData = try JSONDecoder().decode([User].self, from: data)
            DispatchQueue.main.sync {
                for u in userData {
                    if (u.student_id == user && u.password == password) {
                        approved = true
                        break
                    }
                }
            }
            
        } catch let jsonError {
            print(jsonError)
        }
        
    }.resume()
    
    return approved
}


func alertOk(title: String, message: String, vc: UIViewController) -> Void {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
    vc.present(alert, animated: true, completion: nil)
}
