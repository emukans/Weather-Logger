//
//  WeatherApi.swift
//  Weather Logger
//
//  Created by Eduard Mukans on 09/04/2019.
//  Copyright © 2019 Eduards Mukans. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire
import RxCocoa
import SwiftyJSON


enum Result<T> {
    case success(T)
    case failure(Error)
}

enum WeatherError: Error {
    
    case ConnectionError
    
}


class WeatherApi {
    
    static var shared: WeatherApi {
        get {
            return WeatherApi()
        }
    }
    
    private enum ApiEndpoint: String {
        case weather = "weather"
        case history = "history/city"
        
        var url: String {
            return Constant.baseUrl + self.rawValue
        }
    }
    
    private enum Constant {
        static let apiKey = "66969060f4ba14df9e21d8b64d61c245"
        static let baseUrl = "https://api.openweathermap.org/data/2.5/"
    }
    
    func getTopFavorites(latitude: Double, longitude: Double) -> Observable<Result<Weather>> {
        let parameters: [String: Any] = [
            "lat": latitude,
            "lon": longitude,
            "units": "metric"
        ]
        
        let response = try! self.request(parameters: parameters, endpoint: .weather, parser: CurrentWeatherResponseParser())
        
        return response
    }
    
    private func request<T: ApiResponseParser>(parameters: [String: Any], endpoint: ApiEndpoint, parser: T) throws -> Observable<Result<T.Model>> {
        let requestParameterList = self.addAuthParameters(parameters)
        
        return RxAlamofire.requestJSON(.get, endpoint.url, parameters: requestParameterList).observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map { response, data in
                do {
                    let json = JSON(data)
                    let parsedData = try parser.parse(data: json)
                    return .success(parsedData)
                } catch {
                    return .failure(error)
                }
            }.catchErrorJustReturn(.failure(WeatherError.ConnectionError))
    }
    
    private func addAuthParameters(_ parameters: [String: Any]) -> [String: Any] {
        let authParameters = ["appid": Constant.apiKey]
        
        return parameters.merging(authParameters) { $1 }
    }
    
}
