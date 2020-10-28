// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import Foundation

enum ActivityPluginError: Error {
    case didFailReadData
    case didFailRequestAuthorization
    case healthDataIsNotAvailable
}

extension ActivityPluginError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .didFailReadData:
            return "didFailReadData"
        case .didFailRequestAuthorization:
            return "didFailRequestAuthorization"
        case .healthDataIsNotAvailable:
            return "healthDataIsNotAvailable"
        }
    }
}
