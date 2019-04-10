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


class WeatherViewModel {
    
    // MARK: - Output
    
    let weather = BehaviorRelay<Double>(value: 0.0)
    let humidity = BehaviorRelay<Double>(value: 0.0)
    let pressure = BehaviorRelay<Double>(value: 0.0)
    let wind = BehaviorRelay<Double>(value: 0.0)
    let location = BehaviorRelay<String>(value: "")
    let weatherDescription = BehaviorRelay<String>(value: "")
    let country = BehaviorRelay<String>(value: "")
    
    
    // MARK: - Internal properties
    
    let disposeBag = DisposeBag()
    private enum Constant {
        static let rigaCoordinates = (56.95, 24.11)
    }
    
    
    // MARK: - Implementation
    
    init() {
        _ = WeatherApi.shared.getTopFavorites(latitude: 56.95, longitude: 24.11).subscribe(onNext: { [weak self] response in
            guard let strongSelf = self else { return }
            
            strongSelf.weather.accept(response.temperature)
            strongSelf.humidity.accept(response.humidity)
            strongSelf.pressure.accept(response.pressure)
            strongSelf.wind.accept(response.wind)
            strongSelf.location.accept(response.location)
            strongSelf.weatherDescription.accept(response.weatherDescription)
            strongSelf.country.accept(response.country)
            
        }).disposed(by: disposeBag)
    }
    
}
