//
//  NetworkSessionProvider.swift
//  NetworkLayer
//
//  Created by Salihcan Kahya on 30.09.2021.
//

import Foundation
import Alamofire

public final class NetworkSessionProvider {
    public static let shared = NetworkSessionProvider()
    private init() { }
        
    private(set) public var session: Alamofire.Session!
    
    public func setupSession(monitors: [EventMonitor] = []) {
        let serverTrustPolicies: [String: ServerTrustEvaluating] = [
            "192.168.1.107": DisabledTrustEvaluator()
        ]

        let serverTrustManager = Alamofire.ServerTrustManager(
            evaluators: serverTrustPolicies
        )
        
        self.session = Alamofire.Session(serverTrustManager: serverTrustManager, eventMonitors: monitors)
    }
}
