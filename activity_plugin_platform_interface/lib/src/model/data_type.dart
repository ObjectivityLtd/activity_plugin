// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';

enum DataType {
  steps,
}

extension DataTypeExtension on DataType {
  String toJson() {
    return describeEnum(this);
  }
}
