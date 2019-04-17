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
        static var coldWeatherColor: UIColor { return UIColor(red:0.635, green:0.843, blue:0.847, alpha:1.0) }
        static var coolWeatherColor: UIColor { return UIColor(red:0.749, green:0.878, blue:0.749, alpha:1.0) }
        static var normalWeatherColor: UIColor { return UIColor(red:0.929, green:0.929, blue:0.918, alpha:1.0) }
        static var warmWeatherColor: UIColor { return UIColor(red:0.941, green:0.878, blue:0.686, alpha:1.0) }
        static var hotWeatherColor: UIColor { return UIColor(red:251/255, green:217/255, blue:211/255, alpha:1.0) }
        static var defaultBackgroundColor: UIColor { return UIColor(red:0.976, green:0.976, blue:0.976, alpha:1.0) }
    }
}
