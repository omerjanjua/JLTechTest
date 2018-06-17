//
//  DataParser.swift
//  JLTechTest
//
//  Created by Omer Janjua on 17/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import Foundation

enum DataParserError: Error {
    case couldNotParseResponse
}

class DataParser<ParsedType> {
    
    typealias ParsedResult = Result<ParsedType, Error>
    
    func parse(_ data: Data) -> ParsedResult {
        return .failure(DataParserError.couldNotParseResponse)
    }
}
