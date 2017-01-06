//
//  MockAppsRepository.swift
//  AppStoreExample
//
//  Created by Francisco Valbuena on 1/4/17.
//  Copyright © 2017 Francisco Valbuena. All rights reserved.
//

import Foundation

class MockAppsRepository: InMemoryAppsRepository {
    var removeAllAppsCalled = false
    
    override func removeAllApps() {
        super.removeAllApps()
        removeAllAppsCalled = true
    }
}
