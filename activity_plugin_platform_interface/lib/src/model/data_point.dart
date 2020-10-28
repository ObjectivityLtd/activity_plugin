// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import 'unit.dart';

class DataPoint {
  final DateTime start;
  final DateTime end;
  final num value;
  final Unit unit;

  const DataPoint(this.start, this.end, this.value, this.unit);

  factory DataPoint.fromJson(Map<String, dynamic> json) {
    return DataPoint(
      DateTime.fromMillisecondsSinceEpoch(json['start']),
      DateTime.fromMillisecondsSinceEpoch(json['end']),
      num.tryParse(json['value'].toString()),
      UnitExtension.fromJson(json['unit']),
    );
  }
}
