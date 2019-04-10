//
//  ApiResponseParser.swift
//  Weather Logger
//
//  Created by Eduard Mukans on 09/04/2019.
//  Copyright © 2019 Eduards Mukans. All rights reserved.
//

import Foundation
import SwiftyJSON

enum ApiResponseParserError: Error {
    
    case ParsingError(String)
    
}


protocol ApiResponseParser {
    
    associatedtype Model
    
    func parse(data: JSON) throws -> Model
    
}
