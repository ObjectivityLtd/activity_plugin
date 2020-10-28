// Copyright (c) 2020 Objectivity. All rights reserved.
// Use of this source code is governed by The MIT License (MIT) that can be
// found in the LICENSE file.

package uk.co.objectivity.activity_plugin.connection

import android.util.Log
import com.google.android.gms.fitness.FitnessOptions
import com.squareup.moshi.JsonAdapter
import com.squareup.moshi.Moshi
import com.squareup.moshi.Types
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import uk.co.objectivity.activity_plugin.extension.toFitness
import uk.co.objectivity.activity_plugin.extension.toModel
import uk.co.objectivity.activity_plugin.model.DataPoint
import uk.co.objectivity.activity_plugin.model.DataType
import uk.co.objectivity.activity_plugin.model.ReadDataParams
import uk.co.objectivity.activity_plugin.service.GoogleFitService
import com.google.android.gms.fitness.data.DataPoint as FitnessDataPoints

inline fun <reified T> Moshi.listAdapter(): JsonAdapter<List<T>> = Types.newParameterizedType(List::class.java, T::class.java).let { this.adapter<List<T>>(it) }
fun MethodChannel.Result.success() = success(null)
fun MethodChannel.Result.error(code: String, errorMessage: String? = null) = error(code, errorMessage, null)

private fun createFitnessOptions(dataTypes: List<DataType>): FitnessOptions {
    return dataTypes.map { it.toFitness() }
            .fold(FitnessOptions.builder(), { acc, value -> acc.addDataType(value, FitnessOptions.ACCESS_READ) })
            .build()
}

interface MethodHandler {
    fun handle(call: MethodCall, result: MethodChannel.Result)
}

object NotImplementedHandler : MethodHandler {
    override fun handle(call: MethodCall, result: MethodChannel.Result) {
        result.notImplemented()
    }
}

class CheckAuthorizationHandler(private val googleFitService: GoogleFitService, private val moshi: Moshi) : MethodHandler {
    override fun handle(call: MethodCall, result: MethodChannel.Result) {
        val dataTypes = moshi.listAdapter<DataType>().fromJson(call.arguments as String).orEmpty()
        Log.d(Config.TAG, "DataTypes: ${dataTypes.joinToString()}")

        val options = createFitnessOptions(dataTypes)
        val authorized = googleFitService.checkAuthorization(options)

        result.success(authorized)
    }
}

class RequestAuthorizationHandler(private val googleFitService: GoogleFitService, private val moshi: Moshi) : MethodHandler {
    override fun handle(call: MethodCall, result: MethodChannel.Result) {
        val dataTypes = moshi.listAdapter<DataType>().fromJson(call.arguments as String).orEmpty()
        Log.d(Config.TAG, "DataTypes: ${dataTypes.joinToString()}")

        val options = createFitnessOptions(dataTypes)
        googleFitService.requestAuthorization(options, {
            result.success()
        }, {
            result.error("request_authorization_canceled")
        })
    }
}

class ReadDataHandler(private val googleFitService: GoogleFitService, private val moshi: Moshi) : MethodHandler {
    override fun handle(call: MethodCall, result: MethodChannel.Result) {
        val params = moshi.adapter(ReadDataParams::class.java).fromJson(call.arguments as String)!!
        Log.d(Config.TAG, "DataTypes: $params")

        googleFitService.readData(
                params.start,
                params.end,
                params.type.toFitness(),
                { handleSuccess(params.type, it, result) },
                { result.error("read_data_error", it.message) }
        )
    }

    private fun handleSuccess(dataType: DataType, dataPoints: List<FitnessDataPoints>, result: MethodChannel.Result) {
        val adapter = moshi.listAdapter<DataPoint>()
        val json = adapter.toJson(dataPoints.map { it.toModel(dataType) })
        result.success(json)
    }
}
