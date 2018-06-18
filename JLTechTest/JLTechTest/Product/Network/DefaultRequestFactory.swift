//
//  DefaultRequestFactory.swift
//  JLTechTest
//
//  Created by Omer Janjua on 18/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import Foundation

protocol RequestFactory {
    func create(fromURL url: URL) -> Request
}

class DefaultRequestFactory: RequestFactory {
    
    func create(fromURL url: URL) -> Request {
        return JLRequest(baseURL: url)
    }
}
