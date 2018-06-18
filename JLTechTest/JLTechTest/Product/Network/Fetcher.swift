//
//  Fetcher.swift
//  JLTechTest
//
//  Created by Omer Janjua on 17/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import Foundation

protocol Request {
    typealias RequestResult = Result<Data, Error>
    typealias Completion = (RequestResult) -> ()
    func get(from path: String, completion: @escaping Completion)
}

class Fetcher<ResultType> {
    
    typealias FetcherResult = Result<ResultType, Error>
    private let request: Request
    private let parser: DataParser<ResultType>
    
    init(request: Request, parser: DataParser<ResultType>) {
        self.request = request
        self.parser = parser
    }
    
    func fetch(path: String, completion: @escaping (FetcherResult) -> ()) {
        request.get(from: path) { [weak self] result in
            self?.handleResponse(result: result, completion: completion)
        }
    }
    
    private func handleResponse(result: Request.RequestResult, completion: (FetcherResult) -> ()) {
        switch result {
        case .failure(let error):
            completion(.failure(error))
        case .success(let response):
            completion(parser.parse(response))
        }
    }
}
