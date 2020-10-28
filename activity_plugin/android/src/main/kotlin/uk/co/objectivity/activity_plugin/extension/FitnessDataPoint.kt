// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

package uk.co.objectivity.activity_plugin.extension

import com.google.android.gms.fitness.data.Field
import uk.co.objectivity.activity_plugin.model.DataPoint
import uk.co.objectivity.activity_plugin.model.DataType
import java.util.concurrent.TimeUnit
import com.google.android.gms.fitness.data.DataPoint as FitnessDataPoint

fun FitnessDataPoint.toModel(dataType: DataType): DataPoint {
    val field = getField(dataType)
    val value = getValueAsString(field)

    return DataPoint(
            this.getStartTime(TimeUnit.MILLISECONDS),
            this.getEndTime(TimeUnit.MILLISECONDS),
            value,
            field.toUnit()
    )
}

private fun FitnessDataPoint.getValueAsString(field: Field): String {
    return when (field) {
        Field.FIELD_STEPS -> getValue(field).asInt().toString()
        else -> ""
    }
}

private fun getField(dataType: DataType): Field {
    return when (dataType) {
        DataType.STEPS -> Field.FIELD_STEPS
    }
}
