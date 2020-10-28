// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import HealthKit
import Foundation

enum DataType: String, Codable {

    // MARK: - Public Values
    case steps

    // MARK: - Public Methods
    func toPlatform() -> HKQuantityType? {
        switch self {
        case .steps:
            return HKObjectType.quantityType(forIdentifier: .stepCount)
        }
    }

    func unit() -> Unit {
        switch self {
        case .steps:
            return .count
        }
    }
}
