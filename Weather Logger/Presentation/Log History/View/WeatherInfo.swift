//
//  WeatherInfo.swift
//  Weather Logger
//
//  Created by Eduard Mukans on 14/04/2019.
//  Copyright © 2019 Eduards Mukans. All rights reserved.
//

import UIKit


class WeatherInfo: UIView {
    
    // MARK: - UI/Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel! {
        willSet {
            newValue.text = ""
        }
    }
    @IBOutlet weak var dateLabel: UILabel! {
        willSet {
            newValue.text = ""
        }
    }
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    // MARK: - Constants
    
    enum ColorPalette {
        case cold
        case cool
        case normal
        case warm
        case hot
        
        var color: UIColor {
            switch self {
            case .cold: return UIColor.WeatherLogger.coldWeatherColor
            case .cool: return UIColor.WeatherLogger.coolWeatherColor
            case .normal: return UIColor.WeatherLogger.normalWeatherColor
            case .warm: return UIColor.WeatherLogger.warmWeatherColor
            case .hot: return UIColor.WeatherLogger.hotWeatherColor
            }
        }
    }
    
    
    // MARK: - Configuration
    
    func configure(withWeather weather: Weather) {
        imageView.image = UIImage(named: weather.iconName)
        temperatureLabel.text = String(format: "%.f\u{00B0}", weather.temperature)
        if (!weather.location.isEmpty && !weather.country.isEmpty) {
            locationLabel.text = "\(weather.location), \(weather.country)"
        }
        
        if weather.timestapm != 0 {
            let date = Date(timeIntervalSince1970: Double(weather.timestapm))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
            dateLabel.text = dateFormatter.string(from: date)
        }
        
        self.layer.cornerRadius = 10
        
        if weather.temperature < -10 {
            self.backgroundColor = ColorPalette.cold.color
        } else if weather.temperature < 5 {
            self.backgroundColor = ColorPalette.cool.color
        } else if weather.temperature < 20 {
            self.backgroundColor = ColorPalette.normal.color
        } else if weather.temperature < 30 {
            self.backgroundColor = ColorPalette.warm.color
        } else {
            self.backgroundColor = ColorPalette.hot.color
        }
    }
    
}
