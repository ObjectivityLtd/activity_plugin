// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import Flutter

final class CheckAuthorizationFlutterMethodsCallHandler: FlutterMethodCallHandlerProtocol {
    
    // MARK: - Private Properties
    private let argumentsDecoder: FlutterArgumentsDecoder
    private let activityAuthorizationService: ActivityAuthorizationServiceProtocol
    
    // MARK: - Instance Initialization
    init(argumentsDecoder: FlutterArgumentsDecoder,
         activityAuthorizationService: ActivityAuthorizationServiceProtocol) {
        
        self.argumentsDecoder = argumentsDecoder
        self.activityAuthorizationService = activityAuthorizationService
    }
    
    // MARK: - FlutterMethodCallHandlerProtocol Methods
    func handleMethodCall(_ arguments: Any?, result: @escaping FlutterResult) {
        /*
        guard let dataTypes = argumentsDecoder.decodeCheckAuthorizationArguments(arguments) else {
            result(FlutterError.exceptionInvalidArguments())
            return
        }
        */
        result(FlutterMethodNotImplemented)
    }
}
