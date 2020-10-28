// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

package uk.co.objectivity.activity_plugin.model

import com.squareup.moshi.JsonClass

@JsonClass(generateAdapter = true)
data class DataPoint(
        val start: Long,
        val end: Long,
        val value: String,
        val unit: Unit
)
