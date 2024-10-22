package com.victorylink.flutter_background_sms

import android.annotation.SuppressLint
import android.annotation.TargetApi
import android.app.Activity
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.telephony.SmsManager
import android.telephony.SubscriptionManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class SmsSender(private val context: Context) {
    @TargetApi(Build.VERSION_CODES.DONUT)
    @SuppressLint("MissingPermission")
    fun sendSMS(shortCode: String, message: String, simSlot: Int, result: MethodChannel.Result) {
        val subscriptionManager = context.getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
        val subscriptionInfoList = subscriptionManager.activeSubscriptionInfoList

        if (simSlot < subscriptionInfoList.size) {
            val subscriptionInfo = subscriptionInfoList[simSlot]
            if (subscriptionInfo.simSlotIndex == simSlot && subscriptionInfo.cardId != null) {
                val smsManager = SmsManager.getSmsManagerForSubscriptionId(subscriptionInfo.subscriptionId)

                val sentIntent = PendingIntent.getBroadcast(context, 0, Intent("SMS_SENT"), PendingIntent.FLAG_UPDATE_CURRENT)
                val deliveryIntent = PendingIntent.getBroadcast(context, 0, Intent("SMS_DELIVERED"), PendingIntent.FLAG_UPDATE_CURRENT)

                val sentReceiver = object : BroadcastReceiver() {
                    override fun onReceive(context: Context?, intent: Intent?) {
                        when (resultCode) {
                            Activity.RESULT_OK -> result.success(true)
                            SmsManager.RESULT_ERROR_GENERIC_FAILURE -> result.success(false)
                            SmsManager.RESULT_ERROR_NO_SERVICE -> result.success(false)
                            SmsManager.RESULT_ERROR_NULL_PDU -> result.success(false)
                            SmsManager.RESULT_ERROR_RADIO_OFF -> result.success(false)
                        }
                        context?.unregisterReceiver(this)
                    }
                }

                context.registerReceiver(sentReceiver, IntentFilter("SMS_SENT"))
                smsManager.sendTextMessage(shortCode, null, message, sentIntent, deliveryIntent)
            } else {
                result.success(false)
            }
        } else {
            result.success(false)
        }
    }
}
