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


class WeatherViewModel {
    
    // MARK: - Output
    
    let weather = BehaviorRelay<Double>(value: 0.0)
    let humidity = BehaviorRelay<Double>(value: 0.0)
    let pressure = BehaviorRelay<Double>(value: 0.0)
    let wind = BehaviorRelay<Double>(value: 0.0)
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
    
    
    // MARK: - Implementation
    
    init() {
        self.locationService.lastUpdatedLocation.observeOn(ConcurrentDispatchQueueScheduler(qos: .background)).ignoreNil().flatMapLatest { (location: CLLocation) in
                return WeatherApi.shared.getTopFavorites(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            }.subscribe(onNext: { [weak self] (response: Result<Weather>) in
                guard let strongSelf = self else { return }
                
                switch response {
                case .failure(let error):
                    print(error)
                case .success(let weather):
                    strongSelf.weather.accept(weather.temperature)
                    strongSelf.humidity.accept(weather.humidity)
                    strongSelf.pressure.accept(weather.pressure)
                    strongSelf.wind.accept(weather.wind)
                    strongSelf.location.accept(weather.location)
                    strongSelf.weatherDescription.accept(weather.weatherDescription)
                    strongSelf.country.accept(weather.country)
                    
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
            }, onError: { error in
                print("subscribtion error")
                
            }).disposed(by: disposeBag)
    }
    
}
