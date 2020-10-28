// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

package uk.co.objectivity.activity_plugin.service

import android.app.Activity
import android.content.Intent
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import kotlin.random.Random

class ActivityFactory {
    private lateinit var activityPluginBinding: ActivityPluginBinding

    private val resultListeners: MutableList<ResultListener> = mutableListOf()

    val activity: Activity
        get() = activityPluginBinding.activity

    fun create(activityRequest: (requestCode: Int, activity: Activity) -> Unit, onSuccess: () -> Unit, onCancel: () -> Unit) {
        val requestCode = Random.nextInt(0, Int.MAX_VALUE)
        val resultListener = ResultListener(
                requestCode,
                onSuccess,
                onCancel,
                this::removeResultListener
        )
        addResultListener(resultListener)

        activityRequest(requestCode, activity)
    }

    private fun removeResultListener(resultListener: ResultListener) {
        activityPluginBinding.removeActivityResultListener(resultListener)
        resultListeners.remove(resultListener)
    }

    private fun addResultListener(resultListener: ResultListener) {
        activityPluginBinding.addActivityResultListener(resultListener)
        resultListeners.add(resultListener)
    }

    fun bind(binding: ActivityPluginBinding) {
        activityPluginBinding = binding
    }

    fun unbind() {
        resultListeners.forEach { activityPluginBinding.removeActivityResultListener(it) }
        resultListeners.clear()
    }
}

private class ResultListener(private val requestCode: Int,
                             private val onSuccess: () -> Unit,
                             private val onCancel: () -> Unit,
                             private val onDone: (ResultListener) -> Unit
) : PluginRegistry.ActivityResultListener {
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (this.requestCode == requestCode) {
            if (resultCode == Activity.RESULT_OK) {
                onSuccess()
            } else {
                onCancel()
            }

            onDone(this)
            return true
        }

        return false
    }
}
