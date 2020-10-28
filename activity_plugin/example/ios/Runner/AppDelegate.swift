// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import UIKit
import Flutter
import activity_plugin

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

    // MARK: - UIApplicationDelegate Methods
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAppDelegateRegistry()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // MARK: - Register Plugins
    static func registerPlugins(with registry: FlutterPluginRegistry) {
        GeneratedPluginRegistrant.register(with: registry)
    }

    // MARK: - Private Methods
    private func setupAppDelegateRegistry() {
        AppDelegate.registerPlugins(with: self)
    }
}
