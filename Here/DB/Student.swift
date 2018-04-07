//
//  Student.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 4/7/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import Foundation
import RealmSwift

class Student: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var lastName = ""
    @objc dynamic var degree = ""
    @objc dynamic var device = ""
    
    convenience init(id: String, name: String, lastName: String, degree: String, device: String) {
        self.init()
        self.id = id
        self.name = name
        self.lastName = lastName
        self.degree = degree
        self.device = device
    }
}
