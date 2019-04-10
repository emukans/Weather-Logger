//
//  Weather.swift
//  Weather Logger
//
//  Created by Eduard Mukans on 09/04/2019.
//  Copyright © 2019 Eduards Mukans. All rights reserved.
//

import Foundation
import Realm
import RealmSwift


class Weather: Object {
    
    @objc dynamic var temperature = 0.0
    @objc dynamic var humidity = 0.0
    @objc dynamic var pressure = 0.0
    @objc dynamic var wind = 0.0
    @objc dynamic var weatherDescription = ""
    @objc dynamic var location = ""
    @objc dynamic var country = ""
    
}
