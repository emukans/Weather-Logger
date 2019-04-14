//
//  RealmConfiguration.swift
//  Weather Logger
//
//  Created by Eduard Mukans on 14/04/2019.
//  Copyright © 2019 Eduards Mukans. All rights reserved.
//

import Foundation
import Realm
import RealmSwift


class RealmConfiguration {
    
    let currentVersion: UInt64 = 1
    
    func getConfig() -> Realm.Configuration {
        return Realm.Configuration(schemaVersion: self.currentVersion)
    }
    
}
