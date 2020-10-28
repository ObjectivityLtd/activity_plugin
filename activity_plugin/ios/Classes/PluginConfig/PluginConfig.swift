// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import Foundation

struct PluginConfig {

    static let id = "uk.co.objectivity/activity"

    struct Channel {
        static let main = "\(PluginConfig.id)/methods"
    }

    struct Methods {
        static let checkAuthorization = "checkAuthorization"
        static let requestAuthorization = "requestAuthorization"
        static let readData = "readData"
    }
    
}
