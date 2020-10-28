// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:activity_plugin/activity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final dataTypes = [DataType.steps];

  String _permissionsGranted = 'Unknown';
  List<DataPoint> dataPoints = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ListView(
            children: [
              Text("AUTHORIZATION GRANTED: $_permissionsGranted"),
              _createGenericButton("CHECK AUTHORIZATION", _checkAuthorization),
              _createGenericButton(
                "REQUEST AUTHORIZATION",
                    () => requestAuthorization(dataTypes),
              ),
              _createGenericButton("READ DATA", _readData),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text("Start date")),
                    DataColumn(label: Text("End date")),
                    DataColumn(label: Text("Value")),
                    DataColumn(label: Text("Unit")),
                  ],
                  rows: _createRows(dataPoints),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _checkAuthorization() async {
    final permissionsGranted = await checkAuthorization(dataTypes);
    setState(() {
      _permissionsGranted = permissionsGranted ? "TRUE" : "FALSE";
    });
  }

  Widget _createGenericButton(String text, Function onPressed) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }

  void _readData() async {
    final end = DateTime.now();
    final start = DateTime(
      end.year,
      end.month,
      end.day,
    ).subtract(
      Duration(
        days: 2,
      ),
    );

    try {
      final dataPoints = await readData(start, end, DataType.steps);

      dataPoints.forEach(
            (dataPoint) =>
            print("start: ${dataPoint.start}, " +
                "end: ${dataPoint.end}, " +
                "value: ${dataPoint.value}, " +
                "unit: ${dataPoint.unit}"),
      );

      /// The iterable must have at least one element.
      /// If it has only one element, that element is returned.
      final steps = dataPoints.isEmpty
          ? 0
          : dataPoints
          .map((e) => e.value)
          .reduce((value, element) => value + element);
      print("Steps today: $steps");

      setState(() {
        this.dataPoints = dataPoints;
      });
    } on PlatformException catch (e) {
      print("PlatformException $e");
    } catch (e) {
      print("catch $e");
    }
  }

  List<DataRow> _createRows(List<DataPoint> dataPoints) {
    return dataPoints.map((dataPoint) {
      return DataRow(cells: [
        DataCell(Text(dataPoint.start.toString())),
        DataCell(Text(dataPoint.end.toString())),
        DataCell(Text(dataPoint.value.toString())),
        DataCell(Text(describeEnum(dataPoint.unit))),
      ]);
    }).toList();
  }
}
