//
//  Optional+Publisher.swift
//  NetworkLayer
//
//  Created by Salihcan Kahya on 30.09.2021.
//

import Combine

extension Optional where Wrapped: Combine.Publisher {
    public func orEmpty() -> AnyPublisher<Wrapped.Output, Wrapped.Failure> {
        return self?.eraseToAnyPublisher() ?? Empty().eraseToAnyPublisher()
    }
}
