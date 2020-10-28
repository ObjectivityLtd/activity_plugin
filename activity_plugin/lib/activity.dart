// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import 'package:activity_plugin_platform_interface/activity_platform_interface.dart';

export 'package:activity_plugin_platform_interface/activity_platform_interface.dart';

/// Works only on Android!
/// Checks application authorisation to read given data types from Google Fit.
Future<bool> checkAuthorization(List<DataType> dataTypes) =>
    ActivityPlatform.instance.checkAuthorization(dataTypes);

/// Request authorization to read the data from Google Fit or Apple Health.
/// On iOS should always be called before reading the data.
/// On Android we can check if the authorization is granted and request only if necessary.
Future<void> requestAuthorization(List<DataType> dataTypes) =>
    ActivityPlatform.instance.requestAuthorization(dataTypes);

/// Reads data points from Google Fit or Apple Health within the given interval and data type.
Future<List<DataPoint>> readData(
  DateTime start,
  DateTime end,
  DataType type,
) =>
    ActivityPlatform.instance.readData(start, end, type);
