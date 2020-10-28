// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import Flutter

final class ReadDataFlutterMethodCallHandler: FlutterMethodCallHandlerProtocol {

    // MARK: - Private Properties
    private let argumentsDecoder: FlutterArgumentsDecoder
    private let activityService: ActivityServiceProtocol

    // MARK: - Instance Initialization
    init(argumentsDecoder: FlutterArgumentsDecoder,
         activityService: ActivityServiceProtocol) {
        
        self.argumentsDecoder = argumentsDecoder
        self.activityService = activityService
    }

    // MARK: - FlutterMethodCallHandlerProtocol Methods
    func handleMethodCall(_ arguments: Any?, result: @escaping FlutterResult) {
        guard let parameters = argumentsDecoder.decodeReadDataArguments(arguments) else {
            result(FlutterError.exceptionInvalidArguments())
            return
        }
        activityService.readData(
            parameters,
            onCompletion: { models in result(models.toJSON()) },
            onError: { error in result(FlutterError.exceptionFromError(error)) })
    }
}

