//
//  CurrentWeatherResponseParserTests.swift
//  Weather LoggerTests
//
//  Created by Eduard Mukans on 09/04/2019.
//  Copyright © 2019 Eduards Mukans. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Weather_Logger

class CurrentWeatherResponseParserTests: XCTestCase {
    
    let mockData = "{\"coord\":{\"lon\":139,\"lat\":35},\"sys\":{\"country\":\"JP\",\"sunrise\":1369769524,\"sunset\":1369821049},\"weather\":[{\"id\":804,\"main\":\"clouds\",\"description\":\"overcast clouds\",\"icon\":\"04n\"}],\"main\":{\"temp\":289.5,\"humidity\":89,\"pressure\":1013,\"temp_min\":287.04,\"temp_max\":292.04},\"wind\":{\"speed\":7.31,\"deg\":187.002},\"rain\":{\"3h\":0},\"clouds\":{\"all\":92},\"dt\":1369824698,\"id\":1851632,\"name\":\"Shuzenji\",\"cod\":200}"
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSuccessWithCorrectData() {
        let data = mockData.data(using: .utf8)!
        let json = JSON(data)
        let result = try! CurrentWeatherResponseParser().parse(data: json)
        
        XCTAssertEqual(result.temperature, 289.5)
        XCTAssertEqual(result.humidity, 89)
        XCTAssertEqual(result.pressure, 1013)
        XCTAssertEqual(result.weatherDescription, "overcast clouds")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
