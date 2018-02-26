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
    @objc dynamic var building = ""
    @objc dynamic var room = ""
    @objc dynamic var red: Float = 0.0
    @objc dynamic var blue: Float = 0.0
    @objc dynamic var green: Float = 0.0
    @objc dynamic var alpha: Float = 0.0
    
    convenience init(name: String, group: String, building: String, room: String) {
        self.init()
        self.name = name
        self.group = group
        self.building = building
        self.room = room
        self.red = 0.2039215686
        self.green = 0.2274509804
        self.blue = 0.2509803922
        self.alpha = 1
    }
    
    convenience init(name: String, group: String, building: String, room: String, red: Float, green: Float, blue: Float, alpha: Float) {
        self.init()
        self.name = name
        self.group = group
        self.building = building
        self.room = room
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}
