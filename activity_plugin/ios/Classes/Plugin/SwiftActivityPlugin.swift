// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import Flutter
import UIKit

public class SwiftActivityPlugin: NSObject {

    // MARK: - Private Properties
    private let dependencyContainer = DependencyContainer.instance

}

// MARK: - FlutterPlugin
extension SwiftActivityPlugin: FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: PluginConfig.Channel.main,
            binaryMessenger: registrar.messenger())
        let instance = SwiftActivityPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let methodCallHandler = FlutterMethodCallHandler(dependencyContainer: dependencyContainer)
        methodCallHandler.handle(call, result: result)

    }
}
