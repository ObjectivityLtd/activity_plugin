// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import HealthKit
import Foundation

enum Unit: String, Codable {

    // MARK: - Public Values
    case count

    // MARK: - Public Methods
    func toPlatform() -> HKUnit {
        switch self {
        case .count:
            return HKUnit.count()
        }
    }
}
