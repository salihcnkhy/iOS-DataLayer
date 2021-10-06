//
//  AnyRequest.swift
//  NetworkLayer
//
//  Created by Salihcan Kahya on 28.09.2021.
//
import Combine


public protocol AnyRequest { }

extension AnyRequest {
    func publisher() -> AnyPublisher<AnyRequest, Never> {
        return Just<AnyRequest>(self).eraseToAnyPublisher()
    }
}
