package me.wolszon.admob_native_ad

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import com.google.android.gms.ads.MobileAds;

class AdmobNativeAdPlugin : MethodCallHandler {
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            registrar
                    .platformViewRegistry()
                    .registerViewFactory("me.wolszon.reddigram/admob_native_ad", AdMobNativeAd.Factory(registrar.messenger()))

            val channel = MethodChannel(registrar.messenger(), "admob_native_ad")
            channel.setMethodCallHandler(AdmobNativeAdPlugin())

            MobileAds.initialize(this) {}
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else {
            result.notImplemented()
        }
    }
}
