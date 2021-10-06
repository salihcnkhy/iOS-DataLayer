//
//  RemoteDataManager.swift
//  NetworkLayer
//
//  Created by Salihcan Kahya on 28.09.2021.
//

import Foundation
import Combine
import Alamofire

public protocol RemoteDataManager: DataManager {
    var session: Session { get }
    func makeRequest() -> AnyPublisher<Data, Error>
}
