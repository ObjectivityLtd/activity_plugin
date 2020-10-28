// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

final class FlutterArgumentsDecoder {

    // MARK: - Private Properties
    private let jsonDecoder = JSONDecoder()

    // MARK: - Public Methods
    func decodeCheckAuthorizationArguments(_ arguments: Any?) -> [DataType]? {
        guard let decoded = decode([String].self, from: arguments) else { return nil }
        return decoded.map { DataType(rawValue: $0) }.compactMap { $0 }
    }
    func decodeRequestAuthorizationArguments(_ arguments: Any?) -> [DataType]? {
        guard let decoded = decode([String].self, from: arguments) else { return nil }
        return decoded.map { DataType(rawValue: $0) }.compactMap { $0 }
    }
    func decodeReadDataArguments(_ arguments: Any?) -> ReadDataArguments? {
        return decode(ReadDataArguments.self, from: arguments)
    }

    // MARK: - Private Methods
    private func decode<T: Codable>(_ type: T.Type, from callArguments: Any?) -> T? {
        guard let jsonString = callArguments as? String,
            let jsonData = jsonString.data(using: .utf8),
            let results = try? jsonDecoder.decode(type, from: jsonData) else {
                return nil
        }
        return results
    }
}

