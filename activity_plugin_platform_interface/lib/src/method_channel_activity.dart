// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:activity_plugin_platform_interface/activity_platform_interface.dart';
import 'package:activity_plugin_platform_interface/src/config.dart';
import 'package:activity_plugin_platform_interface/src/model/read_data_params.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'model.dart';

const MethodChannel _methodChannel =
    MethodChannel(PluginConfig.methodsChannelName);

class MethodChannelActivity extends ActivityPlatform {
  Future<bool> checkAuthorization(List<DataType> dataTypes) =>
      _methodChannel.invokeMethod<bool>(
        MethodConfig.checkAuthorization,
        jsonEncode(dataTypes.map((value) => value.toJson()).toList()),
      );

  Future<void> requestAuthorization(List<DataType> dataTypes) =>
      _methodChannel.invokeMethod<void>(
        MethodConfig.requestAuthorization,
        jsonEncode(dataTypes.map((value) => value.toJson()).toList()),
      );

  Future<List<DataPoint>> readData(
    DateTime start,
    DateTime end,
    DataType type,
  ) =>
      _methodChannel
          .invokeMethod<String>(
            MethodConfig.readData,
            jsonEncode(ReadDataParams(start, end, type)),
          )
          .then(_deserializeDataPoints);

  List<DataPoint> _deserializeDataPoints(String result) {
    return List.from(jsonDecode(result))
        .map((map) => DataPoint.fromJson(map))
        .toList();
  }
}
