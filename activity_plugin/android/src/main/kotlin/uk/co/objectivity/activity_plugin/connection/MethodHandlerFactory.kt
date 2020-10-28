// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

package uk.co.objectivity.activity_plugin.connection

import com.squareup.moshi.Moshi
import uk.co.objectivity.activity_plugin.service.GoogleFitService

class MethodHandlerFactory(private val googleFitService: GoogleFitService,
                           private val moshi: Moshi) {
    fun create(methodName: MethodName): MethodHandler {
        return when (methodName) {
            MethodName.CHECK_AUTHORIZATION -> CheckAuthorizationHandler(googleFitService, moshi)
            MethodName.REQUEST_AUTHORIZATION -> RequestAuthorizationHandler(googleFitService, moshi)
            MethodName.READ_DATA -> ReadDataHandler(googleFitService, moshi)
            else -> NotImplementedHandler
        }
    }
}
