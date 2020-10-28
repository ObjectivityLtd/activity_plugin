// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

package uk.co.objectivity.activity_plugin.extension

import com.google.android.gms.fitness.data.Field
import uk.co.objectivity.activity_plugin.model.Unit

fun Field.toUnit(): Unit = when (this) {
    Field.FIELD_STEPS -> Unit.COUNT
    else -> Unit.UNKNOWN
}
