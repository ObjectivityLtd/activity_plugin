// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import HealthKit
import Foundation

struct DataPointModel: Codable {

    // MARK: - Public Properties
    let start: Double
    let end: Double
    let value: Double
    let unit: Unit

    // MARK: - Instance Initialization
    init(sample: HKQuantitySample, unit: Unit) {
        self.start = sample.startDate.timeIntervalSince1970InMilliseconds()
        self.end = sample.endDate.timeIntervalSince1970InMilliseconds()
        self.value = sample.quantity.doubleValue(for: unit.toPlatform())
        self.unit = unit
    }
    init(sample: HKCategorySample, unit: Unit) {
        self.start = sample.startDate.timeIntervalSince1970InMilliseconds()
        self.end = sample.endDate.timeIntervalSince1970InMilliseconds()
        self.value = Double(sample.value)
        self.unit = unit
    }

    // MARK: - Factory Methods
    static func fromSamples(_ samples: [HKSample], unit: Unit) -> [DataPointModel] {
        if let samples = samples as? [HKQuantitySample] {
            return fromQuantitySamples(samples, unit: unit)
        }
        if let samples = samples as? [HKCategorySample] {
            return fromCategorySamples(samples, unit: unit)
        }
        return []
    }
    private static func fromQuantitySamples(_ samples: [HKQuantitySample], unit: Unit) -> [DataPointModel] {
        return samples.map { DataPointModel(sample: $0, unit: unit) }
    }
    private static func fromCategorySamples(_ samples: [HKCategorySample], unit: Unit) -> [DataPointModel] {
        return samples.map { DataPointModel(sample: $0, unit: unit) }
    }
}
