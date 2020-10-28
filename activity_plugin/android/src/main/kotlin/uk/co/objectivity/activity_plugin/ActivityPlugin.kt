// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

package uk.co.objectivity.activity_plugin

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel
import uk.co.objectivity.activity_plugin.connection.Config

class ActivityPlugin : FlutterPlugin, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var dependencyContainer: DependencyContainer

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        dependencyContainer = DependencyContainer.getInstance(flutterPluginBinding.applicationContext)

        channel = MethodChannel(flutterPluginBinding.binaryMessenger, Config.Channel.METHODS_CHANNEL_NAME)
        channel.setMethodCallHandler(dependencyContainer.methodCallHandler)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        dependencyContainer.activityFactory.bind(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        dependencyContainer.activityFactory.unbind()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        dependencyContainer.activityFactory.bind(binding)
    }

    override fun onDetachedFromActivity() {
        dependencyContainer.activityFactory.unbind()
    }
}
