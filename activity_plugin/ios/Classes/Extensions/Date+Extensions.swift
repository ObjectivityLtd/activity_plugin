// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import Foundation

extension Date {
    func timeIntervalSince1970InMilliseconds() -> TimeInterval {
        return self.timeIntervalSince1970 * 1000
    }
}
