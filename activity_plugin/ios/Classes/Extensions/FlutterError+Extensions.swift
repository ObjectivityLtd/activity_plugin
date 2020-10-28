// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import Flutter

extension FlutterError {

    // MARK: - ExceptionCode
    private struct ExceptionCode {
        static let invalidArguments = "invalidArguments"
        static let invalidUnexpected = "invalidUnexpected"
        static let invalidException = "invalidException"
    }

    // MARK: - Errors
    static func exceptionInvalidArguments() -> FlutterError {
        return FlutterError(
            code: ExceptionCode.invalidArguments,
            message: nil,
            details: nil)
    }
    static func exceptionInvalidUnexpected() -> FlutterError {
        return FlutterError(
            code: ExceptionCode.invalidUnexpected,
            message: nil,
            details: nil)
    }
    static func exceptionFromError(_ error: Error) -> FlutterError {
        return FlutterError(
            code: (error as NSError).domain,
            message: (error as NSError).localizedDescription,
            details: (error as NSError).userInfo)
    }
}

