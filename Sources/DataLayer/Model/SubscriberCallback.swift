//
//  SubscriberCallback.swift
//  NetworkLayer
//
//  Created by Salihcan Kahya on 6.10.2021.
//

import Foundation

public protocol ISubscriberListener { }

public protocol ISubscriberSubscriptionListener: ISubscriberListener {
    typealias SubscriberOnReceivedSubscription = () -> Void
    var onReceivedSubscription: SubscriberOnReceivedSubscription { get }
}

public protocol ISubscriberFinishedListener: ISubscriberListener {
    typealias SubscriberOnReceivedFinished = () -> Void

    var onReceivedFinished: SubscriberOnReceivedFinished { get }
}

public protocol ISubscriberInputListener: ISubscriberListener {
    typealias Input = Decodable
    typealias SubscriberOnReceivedInput = (_ input: Input) -> Void
    var onInput: SubscriberOnReceivedInput { get }
}

public protocol ISubscriberFailureListener: ISubscriberListener {
    typealias Failure = Error
    typealias SubscriberOnFailure = (_ error: Failure) -> Void
    var onFailure: SubscriberOnFailure { get }
}


