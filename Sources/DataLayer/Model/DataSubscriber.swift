//
//  DataSubscriber.swift
//  NetworkLayer
//
//  Created by Salihcan Kahya on 6.10.2021.
//

import Combine

open class DataSubscriber<TOutput: Decodable>: Subscriber {
    
    public typealias Listener = ISubscriberListener
    
    public typealias Output = TOutput
    public typealias Failure = Error
    
    private var listeners: [Listener]
    
    private var subscription: DataSubscription<Output>?
    
    public init(listeners: [Listener] = []) {
        self.listeners = listeners
    }
    
    public func addListener(listener: Listener) {
        listeners.append(listener)
    }
    
    public func receive(subscription: Subscription) {
        guard let subscription = subscription as? DataSubscription<TOutput> else { fatalError("subscription error") }
        invokeOnReceiveSubscription()
        self.subscription = subscription
        subscription.request(.unlimited)
    }
    
    public func receive(_ input: Output) -> Subscribers.Demand {
        invokeOnReceiveInput(input)
        return .unlimited
    }
    
    public func receive(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            invokeOnReceiveFailure(error)
        case .finished:
            invokeOnReceiveFinished()
        }
    }
    
    private func invokeOnReceiveInput(_ input: Output) {
        listeners
            .compactMap { $0 as? ISubscriberInputListener }
            .forEach { $0.onInput(input) }
    }
    
    private func invokeOnReceiveFailure(_ error: Failure) {
        listeners
            .compactMap { $0 as? ISubscriberFailureListener }
            .forEach { $0.onFailure(error) }
    }
    
    private func invokeOnReceiveFinished() {
        listeners
            .compactMap { $0 as? ISubscriberFinishedListener }
            .forEach { $0.onReceivedFinished() }
    }
    
    private func invokeOnReceiveSubscription() {
        listeners
            .compactMap { $0 as? ISubscriberSubscriptionListener }
            .forEach { $0.onReceivedSubscription() }
    }
}
