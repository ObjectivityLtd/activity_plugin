// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import HealthKit
import Foundation

struct ReadDataArguments: Codable {

    // MARK: - Public Properties
    let start: TimeInterval
    let end: TimeInterval
    let type: DataType

}

extension ReadDataArguments {
    func startDate() -> Date {
        return Date(timeIntervalSince1970: start / 1000)
    }
    func endDate() -> Date {
        return Date(timeIntervalSince1970: end / 1000)
    }
}
