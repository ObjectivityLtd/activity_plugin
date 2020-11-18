package uk.co.objectivity.activity_plugin.service

import android.app.Activity
import android.content.pm.PackageManager
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import kotlin.random.Random

class RequestPermissionsFactory {
    private lateinit var activityPluginBinding: ActivityPluginBinding

    private val resultListeners: MutableList<ResultListener> = mutableListOf()

    private val activity: Activity
        get() = activityPluginBinding.activity

    fun create(requestPermissions: (requestCode: Int, activity: Activity) -> Unit, onSuccess: () -> Unit, onCancel: () -> Unit) {
        val requestCode = Random.nextInt(0, Int.MAX_VALUE)
        val resultListener = ResultListener(
                requestCode,
                onSuccess,
                onCancel,
                this::removeResultListener
        )
        addResultListener(resultListener)

        requestPermissions(requestCode, activity)
    }

    private fun removeResultListener(resultListener: ResultListener) {
        activityPluginBinding.removeRequestPermissionsResultListener(resultListener)
        resultListeners.remove(resultListener)
    }

    private fun addResultListener(resultListener: ResultListener) {
        activityPluginBinding.addRequestPermissionsResultListener(resultListener)
        resultListeners.add(resultListener)
    }

    fun bind(binding: ActivityPluginBinding) {
        activityPluginBinding = binding
    }

    fun unbind() {
        resultListeners.forEach { activityPluginBinding.removeRequestPermissionsResultListener(it) }
        resultListeners.clear()
    }

    private class ResultListener(private val requestCode: Int,
                                 private val onSuccess: () -> Unit,
                                 private val onCancel: () -> Unit,
                                 private val onDone: (ResultListener) -> Unit
    ) : PluginRegistry.RequestPermissionsResultListener {
        override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>?, grantResults: IntArray?): Boolean {
            if (this.requestCode == requestCode) {
                if (grantResults != null && grantResults.all { it == PackageManager.PERMISSION_GRANTED }) {
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
}
