//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by 112471 on 27.09.2021.
//

import Foundation
import Combine
import Alamofire

public struct NetworkManager: RemoteDataManager {
    
    private(set) public var request: AnyRequest
    private(set) public var session: Session
    
    public func makeRequest() -> AnyPublisher<Data, Error> {
    
        let resultPublisher = request.publisher()
            .compactMap {
                $0 as? NetworkRequestProvider
            }
            .flatMap { (request: NetworkRequestProvider) in
                session.request(request)
                    .validate()
                    .publishData()
            }
            .tryMap { reponse -> Data in
                switch reponse.result {
                case .failure(let error):
                    throw error
                case .success(let data):
                    return data
                }
            }
            .retry(2)
            .eraseToAnyPublisher()
        
        return resultPublisher
    }
}

//.catch({ error -> AnyPublisher<HTTPResponse, URLError> in
//     Publishers.Delay(upstream: upstream, interval: 3, tolerance: 1, scheduler: DispatchQueue.global())
//        .print("RETRYYYYY: ")
//        .eraseToAnyPublisher()
//})
