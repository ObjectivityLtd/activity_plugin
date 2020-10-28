// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

package uk.co.objectivity.activity_plugin.connection

object Config {
    const val TAG = "FLUTTER_ACTIVITY"
    const val PLUGIN_ID = "uk.co.objectivity/activity"

    object Channel {
        const val METHODS_CHANNEL_NAME = "$PLUGIN_ID/methods"
    }

    object Methods {
        const val CHECK_AUTHORIZATION = "checkAuthorization"
        const val REQUEST_AUTHORIZATION = "requestAuthorization"
        const val READ_DATA = "readData"
    }
}
