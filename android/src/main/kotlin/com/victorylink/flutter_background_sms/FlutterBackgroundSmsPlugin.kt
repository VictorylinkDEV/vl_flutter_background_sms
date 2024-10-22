package com.victorylink.flutter_background_sms

import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class FlutterBackgroundSmsPlugin : FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "SEND_SMS_METHOD_CHANNEL")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
    if (call.method == "sendSMS") {
      val shortCode = call.argument<String>("shortCode")
      val message = call.argument<String>("message")
      val simSlot = call.argument<Int>("simSlot")

      if (shortCode != null && message != null && simSlot != null) {
        val smsSender = SmsSender(context)
        smsSender.sendSMS(shortCode, message, simSlot, result)
      } else {
        result.error("ERROR", "Invalid arguments", null)
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

