// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

library activity_plugin_platform_interface;

import 'package:activity_plugin_platform_interface/src/method_channel_activity.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'src/model.dart';

export 'src/model.dart';

abstract class ActivityPlatform extends PlatformInterface {
  ActivityPlatform() : super(token: _token);

  static ActivityPlatform _instance = MethodChannelActivity();

  static final Object _token = Object();

  static ActivityPlatform get instance => _instance;

  static set instance(ActivityPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Works only on Android!
  /// Checks application authorisation to read given data types from Google Fit.
  Future<bool> checkAuthorization(List<DataType> dataTypes) =>
      throw UnimplementedError();

  /// Request authorization to read the data from Google Fit or Apple Health.
  /// On iOS should always be called before reading the data.
  /// On Android we can check if the authorization is granted and request only if necessary.
  Future<void> requestAuthorization(List<DataType> dataTypes) =>
      throw UnimplementedError();

  /// Reads data points from Google Fit or Apple Health within the given interval and data type.
  Future<List<DataPoint>> readData(
    DateTime start,
    DateTime end,
    DataType type,
  ) =>
      throw UnimplementedError();
}
