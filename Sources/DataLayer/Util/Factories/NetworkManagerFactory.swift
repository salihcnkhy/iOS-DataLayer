//
//  NetworkManagerFactory.swift
//  NetworkLayer
//
//  Created by Salihcan Kahya on 28.09.2021.
//

import Foundation

public struct NetworkManagerFactory: DataManagerFactory {
    private(set) public var request: NetworkRequestProvider?
    public init(request: NetworkRequestProvider?) {
        self.request = request
    }
    public func returnManager() -> NetworkManager? {
        guard let request = self.request else { return nil }
        return NetworkManager(request: request, session: NetworkSessionProvider.shared.session)
    }
}
