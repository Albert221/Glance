package me.wolszon.reddigram

import android.app.Activity
import android.content.Intent
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    private var oauthResult: MethodChannel.Result? = null

    companion object {
        private const val CHANNEL = "me.wolszon.reddigram/oauth"
        private const val OAUTH_REQUEST_CODE = 1
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "showOauthScreen" -> {
                    val clientId = call.argument<String>("clientId")
                    if (clientId.isNullOrEmpty()) {
                        result.error("No clientId", null, null)
                        return@setMethodCallHandler
                    }

                    oauthResult = result
                    startActivityForResult(OauthActivity.createIntent(this, clientId!!), OAUTH_REQUEST_CODE)
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        when (requestCode) {
            OAUTH_REQUEST_CODE -> {
                if (resultCode == Activity.RESULT_OK) {
                    val code = data?.getStringExtra(OauthActivity.CODE_EXTRA)
                    oauthResult?.success(hashMapOf("code" to code))
                } else {
                    oauthResult?.error("No response", null, null)
                }
            }
            else -> super.onActivityResult(requestCode, resultCode, data)
        }
    }
}
