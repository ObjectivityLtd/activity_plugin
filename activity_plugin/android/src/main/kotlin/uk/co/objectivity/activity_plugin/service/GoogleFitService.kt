// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

package uk.co.objectivity.activity_plugin.service

import android.Manifest
import android.app.Activity
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.google.android.gms.auth.api.signin.GoogleSignIn
import com.google.android.gms.auth.api.signin.GoogleSignInAccount
import com.google.android.gms.fitness.Fitness
import com.google.android.gms.fitness.FitnessOptions
import com.google.android.gms.fitness.data.DataPoint
import com.google.android.gms.fitness.data.DataType
import com.google.android.gms.fitness.request.DataReadRequest
import uk.co.objectivity.activity_plugin.service.RequestAuthorizationStatus.*
import java.util.concurrent.TimeUnit

class GoogleFitService(private val activityFactory: ActivityFactory) {
    private val activity: Activity
        get() = activityFactory.activity

    private fun getAccount(options: FitnessOptions? = null): GoogleSignInAccount? {
        return if (options == null) {
            GoogleSignIn.getLastSignedInAccount(activity)
        } else {
            GoogleSignIn.getAccountForExtension(activity, options)
        }
    }

    fun checkAuthorization(fitnessOptions: FitnessOptions): Boolean = checkFitnessOptions(fitnessOptions) && checkActivityRecognition()

    private fun checkFitnessOptions(fitnessOptions: FitnessOptions) =
            GoogleSignIn.hasPermissions(getAccount(), fitnessOptions)

    private fun checkActivityRecognition(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            ContextCompat.checkSelfPermission(activity, Manifest.permission.ACTIVITY_RECOGNITION) == PackageManager.PERMISSION_GRANTED
        } else {
            true
        }
    }

    fun requestAuthorization(fitnessOptions: FitnessOptions, onSuccess: () -> Unit, onCancel: () -> Unit) {
        RequestAuthorization(fitnessOptions, onSuccess, onCancel)
                .invoke(activityFactory, getAccount())
    }

    fun readData(start: Long,
                 end: Long,
                 dataType: DataType,
                 onSuccess: (List<DataPoint>) -> Unit,
                 onFailure: (Exception) -> Unit) {
        val readRequest = DataReadRequest.Builder()
                .setTimeRange(start, end, TimeUnit.MILLISECONDS)
                .read(dataType)
                .build()
        val fitnessOptions = FitnessOptions.builder().addDataType(dataType).build()
        getAccount(fitnessOptions)!!.let { account ->
            Fitness.getHistoryClient(activity, account)
                    .readData(readRequest)
                    .addOnSuccessListener {
                        it.getDataSet(dataType).dataPoints.let { result -> onSuccess(result) }
                    }.addOnFailureListener {
                        onFailure(it)
                    }
        }
    }
}

private class RequestAuthorization(
        private val fitnessOptions: FitnessOptions,
        private val onSuccess: () -> Unit,
        private val onCancel: () -> Unit
) {
    private var activityRecognition = PENDING
    private var requestPermissions = PENDING
    private var canceled = false

    fun invoke(activityFactory: ActivityFactory, account: GoogleSignInAccount?) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            activityFactory.create({ requestCode, activity ->
                ActivityCompat.requestPermissions(activity,
                        arrayOf(Manifest.permission.ACTIVITY_RECOGNITION),
                        requestCode)
            }, {
                activityRecognition = SUCCEEDED
                trySuccess()
            }, {
                activityRecognition = CANCELED
                cancel()
            })
        } else {
            activityRecognition = SUCCEEDED
            trySuccess()
        }

        activityFactory.create({ requestCode, activity ->
            GoogleSignIn.requestPermissions(
                    activity,
                    requestCode,
                    account,
                    fitnessOptions
            )
        }, {
            requestPermissions = SUCCEEDED
            trySuccess()
        }, {
            requestPermissions = CANCELED
            cancel()
        })
    }

    private fun cancel() {
        if (!canceled) {
            canceled = true
            onCancel()
        }
    }

    private fun trySuccess() {
        if (!canceled
                && activityRecognition == SUCCEEDED
                && requestPermissions == SUCCEEDED
        ) onSuccess()
    }
}

private enum class RequestAuthorizationStatus {
    PENDING,
    SUCCEEDED,
    CANCELED
}
