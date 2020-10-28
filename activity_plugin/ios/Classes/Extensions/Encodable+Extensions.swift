// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import Foundation

extension Encodable {
    func toJSON() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        debugPrint(String(data: jsonData, encoding: .utf8)!)
        return String(data: jsonData, encoding: .utf8)!
    }
}
