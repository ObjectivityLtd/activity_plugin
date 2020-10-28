// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import Flutter

protocol FlutterMethodCallHandlerProtocol {
    func handleMethodCall(_ arguments: Any?, result: @escaping FlutterResult)
}

final class FlutterMethodCallHandler {

    // MARK: - Private Properties
    private let dependencyContainer: DependencyContainer

    // MARK: - Instance Initialization
    init(dependencyContainer: DependencyContainer) {
        self.dependencyContainer = dependencyContainer
    }

    // MARK: - Public Methods
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let handler = self.handler(call, result: result)
        handler?.handleMethodCall(call.arguments, result: result)
    }

    // MARK: - Private Methods
    private func handler(_ call: FlutterMethodCall, result: @escaping FlutterResult) -> FlutterMethodCallHandlerProtocol? {
        let argumentsDecoder = dependencyContainer.argumentsDecoder
        let activityAuthorizationService = dependencyContainer.activityAuthorizationService
        let activityService = dependencyContainer.activityService

        switch call.method {

        case PluginConfig.Methods.checkAuthorization:
            return CheckAuthorizationFlutterMethodsCallHandler(
                argumentsDecoder: argumentsDecoder,
                activityAuthorizationService: activityAuthorizationService)

        case PluginConfig.Methods.requestAuthorization:
            return RequestAuthorizationFlutterMethodCallHandler(
                argumentsDecoder: argumentsDecoder,
                activityAuthorizationService: activityAuthorizationService)

        case PluginConfig.Methods.readData:
            return ReadDataFlutterMethodCallHandler(
                argumentsDecoder: argumentsDecoder,
                activityService: activityService)

        default:
            result(FlutterMethodNotImplemented)
            return nil
        }
    }
}
