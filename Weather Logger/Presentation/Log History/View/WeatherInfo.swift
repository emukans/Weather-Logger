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
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
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
            case .cold:
                return UIColor(red:0.539, green:0.621, blue:0.805, alpha:1.0)
            case .cool:
                return UIColor(red:0.797, green:0.902, blue:0.898, alpha:1.0)
            case .normal:
                return UIColor(red:0.589, green:0.789, blue:0.523, alpha:1.0)
            case .warm:
                return UIColor(red:0.992, green:0.871, blue:0.551, alpha:1.0)
            case .hot:
                return UIColor(red:0.965, green:0.633, blue:0.191, alpha:1.0)
            }
        }
    }
    
    
    // MARK: - Configuration
    
    func configure(withWeather weather: Weather) {
        imageView.image = UIImage(named: weather.iconName)
        weatherDescriptionLabel.text = weather.weatherDescription
        temperatureLabel.text = String(format: "%.f\u{00B0}", weather.temperature)
        if (weather.location.isEmpty || weather.country.isEmpty) {
            locationLabel.text = ""
        } else {
            locationLabel.text = "\(weather.location), \(weather.country)"
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
