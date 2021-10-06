//
//  NetworkDataProvider.swift
//  NetworkLayer
//
//  Created by 112471 on 27.09.2021.
//

import Foundation
import Combine

open class DataPublisher<TData: Decodable>: Publisher {
    
    public typealias Output = TData
    public typealias Failure = Error
    
    public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = DataSubscription<S.Input>(subsriber: subscriber as! DataSubscriber<TData>, publisher: provide())
        subscriber.receive(subscription: subscription)
    }
    
    
    private var remoteManager: RemoteDataManager?
    private var cacheDataManager: CacheDataManager?
    private var coreDataManager: CoreDataManager?
            
    let dataRequestProvider: DataRequestProvider
    
    public init(dataRequestProvider: DataRequestProvider) {
        self.dataRequestProvider = dataRequestProvider
        self.remoteManager = NetworkManagerFactory(request: dataRequestProvider.networkRequestProvider).returnManager()
    }
        
    public func provide() -> AnyPublisher<TData, Error> {
                
        let remoteUpStream = self.remoteManager?.makeRequest()

        return remoteUpStream
            .orEmpty()
            .decode(type: TData.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
