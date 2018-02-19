//
//  Course.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 2/15/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import Foundation
import RealmSwift

class Course: Object {
    @objc dynamic var name = ""
    @objc dynamic var group = ""
    @objc dynamic var location = ""
    
    convenience init(name: String, group: String, locationBuilding: String, locationRoom: String) {
        self.init()
        self.name = name
        self.group = group
        self.location = locationBuilding + " - " + locationRoom
    }
}
