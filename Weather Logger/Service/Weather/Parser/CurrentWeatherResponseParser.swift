//
//  CurrentWeatherResponseParser.swift
//  Weather Logger
//
//  Created by Eduard Mukans on 09/04/2019.
//  Copyright © 2019 Eduards Mukans. All rights reserved.
//

import Foundation
import SwiftyJSON


class CurrentWeatherResponseParser: ApiResponseParser {
    
    typealias Model = Weather
    
    func parse(data: JSON) throws -> Model {
        guard
            let weatherDesctiption = data["weather"].arrayValue.first,
            let description = weatherDesctiption["description"].string
            else {
            throw ApiResponseParserError.ParsingError("Failed to parse current weather response")
        }
        
        let model = Model()
        model.temperature = data["main"]["temp"].doubleValue
        model.humidity = data["main"]["humidity"].doubleValue
        model.pressure = data["main"]["pressure"].doubleValue
        model.weatherDescription = description
        model.location = data["name"].stringValue
        model.wind = data["wind"]["speed"].doubleValue
        model.country = data["sys"]["country"].stringValue
        
        return model
    }
    
}
