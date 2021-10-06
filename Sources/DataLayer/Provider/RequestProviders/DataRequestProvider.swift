//
//  DataRequestProvider.swift
//  NetworkLayer
//
//  Created by Salihcan Kahya on 30.09.2021.
//

import Foundation

public struct DataRequestProvider {
    public init(networkRequestProvider: NetworkRequestProvider?) {
        self.networkRequestProvider = networkRequestProvider
    }
    
    let networkRequestProvider: NetworkRequestProvider?
}
