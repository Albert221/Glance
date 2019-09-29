package me.wolszon.reddigram

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import me.wolszon.reddigram.DownloadPhotoService.Companion.EXTRA_URL

class MainActivity : FlutterActivity() {
    private var photoDownloadUrl: String? = null

    companion object {
        private const val CHANNEL = "me.wolszon.reddigram"
        private const val WRITE_STORAGE_REQUEST_CODE = 2
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "downloadPhoto" -> {
                    val photoUrl = call.argument<String>("url")
                    if (photoUrl.isNullOrEmpty()) {
                        result.error("No photoUrl", null, null)
                        return@setMethodCallHandler
                    }

                    result.success(null)

                    photoDownloadUrl = photoUrl
                    startDownloadPhotoService()
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun startDownloadPhotoService() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE)
                != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(
                    this,
                    arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE),
                    WRITE_STORAGE_REQUEST_CODE)
        } else {
            Intent(this, DownloadPhotoService::class.java).also {
                it.putExtra(EXTRA_URL, photoDownloadUrl)
                ContextCompat.startForegroundService(this, it)
            }
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        when (requestCode) {
            WRITE_STORAGE_REQUEST_CODE -> {
                if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    startDownloadPhotoService()
                }
            }
            else -> super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        }
    }
}
