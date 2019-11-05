package me.wolszon.reddigram

import android.Manifest
import android.app.DownloadManager
import android.content.Context
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Bundle
import android.os.Environment
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.File

class MainActivity : FlutterActivity() {
    private var photoDownloadUrl: String? = null

    companion object {
        private const val CHANNEL = "me.wolszon.reddigram"
        private const val WRITE_STORAGE_DOWNLOAD_PHOTO_CODE = 2
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
                    downloadPhoto(photoUrl)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun downloadPhoto(url: String) {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE)
                != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(
                    this,
                    arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE),
                    WRITE_STORAGE_DOWNLOAD_PHOTO_CODE)
        } else {
            val downloadManager = getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager
            val photoUri = Uri.parse(url)

            val request = DownloadManager.Request(photoUri).apply {
                setDestinationInExternalPublicDir(Environment.DIRECTORY_PICTURES,
                        "Glance" + File.separator + photoUri.lastPathSegment)
                setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED)
            }

            downloadManager.enqueue(request)
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        when (requestCode) {
            WRITE_STORAGE_DOWNLOAD_PHOTO_CODE -> {
                if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    downloadPhoto(photoDownloadUrl!!)
                }
            }
            else -> super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        }
    }
}
