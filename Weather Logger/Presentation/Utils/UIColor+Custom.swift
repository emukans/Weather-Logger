//
//  UIColor+Custom.swift
//  Weather Logger
//
//  Created by Eduard Mukans on 15/04/2019.
//  Copyright © 2019 Eduards Mukans. All rights reserved.
//

import UIKit

extension UIColor {
    struct WeatherLogger {
        static var coldWeatherColor: UIColor { return UIColor(red:0.539, green:0.621, blue:0.805, alpha:1.0) }
        static var coolWeatherColor: UIColor { return UIColor(red:0.797, green:0.902, blue:0.898, alpha:1.0) }
        static var normalWeatherColor: UIColor { return UIColor(red:0.589, green:0.789, blue:0.523, alpha:1.0) }
        static var warmWeatherColor: UIColor { return UIColor(red:0.992, green:0.871, blue:0.551, alpha:1.0) }
        static var hotWeatherColor: UIColor { return UIColor(red:0.965, green:0.633, blue:0.191, alpha:1.0) }
        static var defaultBackgroundColor: UIColor { return UIColor(red:0.976, green:0.976, blue:0.976, alpha:1.0) }
    }
}
