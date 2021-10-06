//
//  DataSubscription.swift
//  NetworkLayer
//
//  Created by Salihcan Kahya on 6.10.2021.
//

import Combine

open class DataSubscription<Output: Decodable>: Subscription {
    typealias Target = DataSubscriber<Output>
    typealias Source = AnyPublisher<Output, Error>
    
    var subscriber: Target?
    var publisher: Source?

    var anyCancellable: AnyCancellable?
    init(subsriber: Target, publisher: Source) {
        self.subscriber = subsriber
        self.publisher = publisher
        sinkPublisher()
    }
    
    public func request(_ demand: Subscribers.Demand) {
        
    }
    
    public func cancel() {
        anyCancellable?.cancel()
        subscriber = nil
    }
    
    private func sinkPublisher() {
        guard let subscriber = self.subscriber else { return }
        anyCancellable = publisher
            .orEmpty()
            .sink { completion in
                subscriber.receive(completion: completion)
            } receiveValue: { value in
               _ = subscriber.receive(value)
            }
    }
    
    deinit {
        print("deinigni")
    }
}
