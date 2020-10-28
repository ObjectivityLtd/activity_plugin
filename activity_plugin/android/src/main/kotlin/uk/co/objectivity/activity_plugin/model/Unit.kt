// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

package uk.co.objectivity.activity_plugin.model

import com.squareup.moshi.FromJson
import com.squareup.moshi.ToJson

enum class Unit(val rawName: String) {
    COUNT("count"),
    UNKNOWN("unknown");

    class Adapter {
        @FromJson
        fun fromJson(json: String): Unit = values().find { it.rawName == json }!!

        @ToJson
        fun toJson(value: Unit): String = value.rawName
    }
}
