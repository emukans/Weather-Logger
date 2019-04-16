//
//  WeatherViewModel.swift
//  Weather Logger
//
//  Created by Eduard Mukans on 09/04/2019.
//  Copyright © 2019 Eduards Mukans. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation
import Realm
import RealmSwift


class WeatherViewModel {
    
    // MARK: - Output
    
    let weather = BehaviorRelay<Double>(value: 0.0)
    let timestamp = BehaviorRelay<Int>(value: 0)
    let location = BehaviorRelay<String>(value: "")
    let weatherDescription = BehaviorRelay<String>(value: "")
    let country = BehaviorRelay<String>(value: "")
    let iconName = BehaviorRelay<WeatherIconType>(value: .fewClouds)
    
    
    // MARK: - Types
    
    enum WeatherIconType: String {
        case clearSky = "clear-sky"
        case brokenClouds = "broken-clouds"
        case fewClouds = "few-clouds"
        case mist = "mist"
        case rain = "rain"
        case scatteredClouds = "scattered-clouds"
        case showerRain = "shower-rain"
        case snow = "snow"
        case thunderstorm = "thunderstorm"
    }
    
    // MARK: - Internal properties
    
    let disposeBag = DisposeBag()
    
    let locationService = LocationService.shared
    let serviceError = PublishRelay<String>()
    
    
    // MARK: - Implementation
    
    init() {
        self.locationService.lastUpdatedLocation.observeOn(ConcurrentDispatchQueueScheduler(qos: .background)).ignoreNil().flatMapLatest { (location: CLLocation) in
                return WeatherApi.shared.getTopFavorites(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            }.subscribe(onNext: { [weak self] (response: Result<Weather>) in
                guard let strongSelf = self else { return }
                
                switch response {
                case .failure:
                    strongSelf.serviceError.accept("Weather service is not available.")
                case .success(let weather):
                    strongSelf.weather.accept(weather.temperature)
                    strongSelf.location.accept(weather.location)
                    strongSelf.weatherDescription.accept(weather.weatherDescription)
                    strongSelf.country.accept(weather.country)
                    strongSelf.timestamp.accept(weather.timestapm)
                    
                    let iconName: WeatherIconType
                    switch weather.iconName {
                    case "01d", "01n":
                        iconName = .clearSky
                    case "02d", "02n":
                        iconName = .fewClouds
                    case "03d", "03n":
                        iconName = .scatteredClouds
                    case "04d", "04n":
                        iconName = .brokenClouds
                    case "09d", "09n":
                        iconName = .showerRain
                    case "10d", "10n":
                        iconName = .rain
                    case "11d", "11n":
                        iconName = .thunderstorm
                    case "13d", "13n":
                        iconName = .snow
                    case "50d", "50n":
                        iconName = .mist
                    default:
                        iconName = .fewClouds
                    }
                    strongSelf.iconName.accept(iconName)
                }
            }, onError: { [weak self] error in
                self?.serviceError.accept("Please check your connection.")
            }).disposed(by: disposeBag)
        
        self.serviceError.observeOn(MainScheduler.instance).subscribe(onNext: { message in
            NotificationView.showFailureAlert(message: message)
        }).disposed(by: disposeBag)
    }
    
    func logWeather() {
        let weather = Weather()
        weather.temperature = self.weather.value
        weather.weatherDescription = self.weatherDescription.value
        weather.location = self.location.value
        weather.country = self.country.value
        weather.iconName = self.iconName.value.rawValue
        weather.timestapm = self.timestamp.value
        weather.id = "\(self.timestamp.value)-\(self.location.value)".hashValue
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(weather, update: true)
            }
        } catch {
            NotificationView.showFailureAlert(message: "Can't save weather right now.")
            return
        }
        
        NotificationView.showSuccessAlert(message: "Weather saved.")
    }
    
}
