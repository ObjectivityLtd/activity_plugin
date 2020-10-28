// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

class PluginConfig {
  static const id = "uk.co.objectivity/activity";
  static const methodsChannelName = "${PluginConfig.id}/methods";
}

class MethodConfig {
  static const checkAuthorization = "checkAuthorization";
  static const requestAuthorization = "requestAuthorization";
  static const readData = "readData";
}
