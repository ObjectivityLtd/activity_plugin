// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

package uk.co.objectivity.activity_plugin.extension

import uk.co.objectivity.activity_plugin.model.DataType
import com.google.android.gms.fitness.data.DataType as FitnessDataType

fun DataType.toFitness(): FitnessDataType {
    when (this) {
        DataType.STEPS -> return FitnessDataType.TYPE_STEP_COUNT_DELTA
    }
}