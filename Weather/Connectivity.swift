//
//  Connectivity.swift
//  StyleShaker
//
//  Created by alexandre pouget on 29/06/2016.
//  Copyright © 2016 alexandre pouget. All rights reserved.
//

import Foundation


class Connectivity{
    static func hasConnectivity() -> Bool {
        let reachability:Reachability = Reachability.forInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus().rawValue
        return networkStatus != 0
        
    }
}
