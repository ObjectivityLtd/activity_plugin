// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import HealthKit

protocol ActivityAuthorizationServiceProtocol {
    func requestAuthorization(
        for types: [DataType],
        onGranted: @escaping () -> Void,
        onError: @escaping (Error) -> Void)
}

final class ActivityAuthorizationService {

    // MARK: - Private Properties
    private let healthStore: HKHealthStore

    // MARK: - Instance Initialization
    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

}

// MARK: - ActivityAuthorizationServiceProtocol
extension ActivityAuthorizationService: ActivityAuthorizationServiceProtocol {
    func requestAuthorization(
        for types: [DataType],
        onGranted: @escaping () -> Void,
        onError: @escaping (Error) -> Void) {

        guard HKHealthStore.isHealthDataAvailable() else {
            onError(ActivityPluginError.healthDataIsNotAvailable)
            return
        }

        let typesToRead = types.compactMap { $0.toPlatform() }
        let typesToReadSet = Set(typesToRead)
        healthStore.requestAuthorization(toShare: nil, read: typesToReadSet) { _, error in
            error == nil
                ? onGranted()
                : onError(error ?? ActivityPluginError.didFailRequestAuthorization)
        }
    }
}
