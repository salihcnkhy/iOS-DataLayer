//
//  DataManagerFactory.swift
//  NetworkLayer
//
//  Created by Salihcan Kahya on 28.09.2021.
//

import Foundation

public protocol DataManagerFactory {
    associatedtype ManagerType: DataManager
    associatedtype RequestType: AnyRequest
    var request: RequestType? { get }
    init(request: RequestType?)
    func returnManager() -> ManagerType?
}
