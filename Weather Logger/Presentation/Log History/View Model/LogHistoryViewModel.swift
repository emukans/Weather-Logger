//
//  LogHistoryViewModel.swift
//  Weather Logger
//
//  Created by Eduard Mukans on 14/04/2019.
//  Copyright © 2019 Eduards Mukans. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Differentiator
import RealmSwift


class LogHistoryViewModel {
    
    let logHistoryData = BehaviorRelay<[SectionModel<String, Weather>]>(value: [])
    var observeToken: NotificationToken?
    
    init() {
        let realm = try! Realm()
        observeToken = realm.observe { [weak self] notification, realm in
            self?.updateData()
        }
        
        self.updateData()
    }
    
    func updateData() {
        let realm = try! Realm()
        var initialWeatherList: [Weather] = []
        let dbWeather = realm.objects(Weather.self).sorted(byKeyPath: "timestapm", ascending: false)
        
        for i in 0..<min(dbWeather.count, 20) {
            initialWeatherList.append(dbWeather[i])
        }
        let sectionModel = SectionModel(model: "", items: initialWeatherList)
        logHistoryData.accept([sectionModel])
    }
    
    func removeItem(at index: IndexPath) {
        guard let section = logHistoryData.value.first else { return }
        
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.delete(section.items[index.row])
            }
        } catch {
            NotificationView.showFailureAlert(message: "Can't delete log right now.")
        }
    }
    
}
