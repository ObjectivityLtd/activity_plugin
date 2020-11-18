// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

package uk.co.objectivity.activity_plugin

import android.content.Context
import com.squareup.moshi.Moshi
import uk.co.objectivity.activity_plugin.connection.MethodCallHandler
import uk.co.objectivity.activity_plugin.connection.MethodHandlerFactory
import uk.co.objectivity.activity_plugin.model.DataType
import uk.co.objectivity.activity_plugin.service.ActivityFactory
import uk.co.objectivity.activity_plugin.service.GoogleFitService
import uk.co.objectivity.activity_plugin.service.RequestPermissionsFactory
import uk.co.objectivity.activity_plugin.model.Unit as ModelUnit

class DependencyContainer private constructor() {
    val methodCallHandler: MethodCallHandler

    val activityFactory = ActivityFactory()
    val requestPermissionsFactory = RequestPermissionsFactory()

    init {
        val moshi = Moshi.Builder()
                .add(DataType.Adapter())
                .add(ModelUnit.Adapter())
                .build()
        val googleFitService = GoogleFitService(activityFactory, requestPermissionsFactory)
        val methodHandFactory = MethodHandlerFactory(googleFitService, moshi)

        methodCallHandler = MethodCallHandler(methodHandFactory)
    }

    companion object {
        @Volatile
        private var INSTANCE: DependencyContainer? = null

        fun getInstance() = INSTANCE ?: synchronized(this) {
            INSTANCE ?: DependencyContainer().also { INSTANCE = it }
        }
    }
}
