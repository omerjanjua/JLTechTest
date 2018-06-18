//
//  ImageInteractor.swift
//  JLTechTest
//
//  Created by Omer Janjua on 17/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import Foundation

typealias ImageResult = Result<Data, Error>

protocol ImageInteracting {
    func fetch(from url: URL, completion: @escaping (ImageResult) -> ())
}

class ImageInteractor: ImageInteracting {
 
    enum Error: Swift.Error {
        case requestAlreadyInProgress
    }
    
    private let requestFactory: RequestFactory
    private var requests = [URL: Request]()
    
    init(requestFactory: RequestFactory = DefaultRequestFactory()) {
        self.requestFactory = requestFactory
    }
    
    func fetch(from url: URL, completion: @escaping (ImageResult) -> ()) {
        guard requests[url] == nil else {
            completion(.failure(Error.requestAlreadyInProgress))
            return
        }
        let request = requestFactory.create(fromURL: url)
        requests[url] = request
        request.get(from: "") { [weak self] result in
            _ = self?.requests.removeValue(forKey: url)
            completion(result)
        }
    }
}
