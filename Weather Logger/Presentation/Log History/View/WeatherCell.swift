//
//  WeatherCell.swift
//  Weather Logger
//
//  Created by Eduard Mukans on 14/04/2019.
//  Copyright © 2019 Eduards Mukans. All rights reserved.
//

import UIKit


class WeatherCell: UITableViewCell {
    
    // MARK: - UI/Outlets
    
    @IBOutlet weak var infoView: UIView!
    
    
    // MARK: - Properties
    
    lazy var weatherInfo: WeatherInfo = {
        let view = WeatherInfo.loadFromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        self.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "H:|-20-[view]-20-|", options: [], metrics: nil, views: ["view":view]))
        self.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "V:|-10-[view]-10-|", options: [], metrics: nil, views: ["view":view]))
        
        return view
    }()
    
    
    // MARK: - Configuration
    
    func configure(withModel model: Weather) {
        self.backgroundColor = UIColor.WeatherLogger.defaultBackgroundColor
        weatherInfo.configure(withWeather: model)
    }
    
}
