// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

package uk.co.objectivity.activity_plugin.connection

enum class MethodName(private val rawMethodName: String? = null) {
    CHECK_AUTHORIZATION(Config.Methods.CHECK_AUTHORIZATION),
    REQUEST_AUTHORIZATION(Config.Methods.REQUEST_AUTHORIZATION),
    READ_DATA(Config.Methods.READ_DATA),
    UNKNOWN;

    companion object {
        fun fromRawMethodName(rawMethodName: String): MethodName =
                values().firstOrNull { it.rawMethodName == rawMethodName }
                        ?: UNKNOWN
    }
}
