//
//  CacheManager.swift
//  NetworkLayer
//
//  Created by 112471 on 27.09.2021.
//

import Foundation

public protocol CoreDataManager {
    
}

public protocol CacheDataManager {
    
}

public struct CacheManager: CacheDataManager {
    private init() { }
    
    public static let shared = CacheManager()
    
}
