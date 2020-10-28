// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import HealthKit
import Foundation

class DependencyContainer {

    // MARK: - Instance
    static let instance = DependencyContainer()

    // MARK: - Public Properties
    let argumentsDecoder: FlutterArgumentsDecoder
    let activityAuthorizationService: ActivityAuthorizationServiceProtocol
    let activityService: ActivityServiceProtocol

    // MARK: - Instance Initalization
    private init() {
        let argumentsDecoder = FlutterArgumentsDecoder()
        let healthStore = HKHealthStore()

        self.argumentsDecoder = argumentsDecoder
        self.activityAuthorizationService = ActivityAuthorizationService(healthStore: healthStore)
        self.activityService = ActivityService(healthStore: healthStore)
    }
}

