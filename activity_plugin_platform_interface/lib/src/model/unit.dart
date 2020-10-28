// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';

enum Unit {
  count,
  unknown,
}

extension UnitExtension on Unit {
  static Unit fromJson(String unit) {
    return Unit.values.firstWhere((value) => describeEnum(value) == unit);
  }
}
