// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import 'data_type.dart';

class ReadDataParams {
  static const _startParam = 'start';
  static const _endParam = 'end';
  static const _typeParam = 'type';

  final DateTime start;
  final DateTime end;
  final DataType type;

  ReadDataParams(this.start, this.end, this.type);

  Map<String, dynamic> toJson() => <String, dynamic>{
        _startParam: start.millisecondsSinceEpoch,
        _endParam: end.millisecondsSinceEpoch,
        _typeParam: type.toJson()
      };
}
