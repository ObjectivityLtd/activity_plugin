// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import HealthKit

protocol ActivityServiceProtocol {
    func readData(
        _ parameters: ReadDataArguments,
        onCompletion: @escaping ([DataPointModel]) -> Void,
        onError: @escaping (Error) -> Void)
}

final class ActivityService {

    // MARK: - Private Properties
    private let healthStore: HKHealthStore

    // MARK: - Instance Initialization
    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

}

// MARK: - ActivityServiceProtocol
extension ActivityService: ActivityServiceProtocol {
    func readData(
        _ parameters: ReadDataArguments,
        onCompletion: @escaping ([DataPointModel]) -> Void,
        onError: @escaping (Error) -> Void) {

        guard HKHealthStore.isHealthDataAvailable() else {
            onError(ActivityPluginError.healthDataIsNotAvailable)
            return
        }

        let query = HKSampleQuery(arguments: parameters) { _, samples, error in
            samples != nil
                ? onCompletion(DataPointModel.fromSamples(samples!, unit: parameters.type.unit()))
                : onError(error ?? ActivityPluginError.didFailReadData)
        }
        healthStore.execute(query)
    }
}

