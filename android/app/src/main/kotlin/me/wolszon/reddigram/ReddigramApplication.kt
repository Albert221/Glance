package me.wolszon.reddigram

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import io.flutter.app.FlutterApplication
import java.util.concurrent.atomic.AtomicInteger

class ReddigramApplication : FlutterApplication() {
    companion object {
        const val DOWNLOAD_CHANNEL_ID = "DOWNLOAD_CHANNEL"

        private val notificationIdAtomic = AtomicInteger(1)
        val newNotificationId
            get() = notificationIdAtomic.getAndIncrement()
    }

    override fun onCreate() {
        super.onCreate()

        createNotificationChannel()
    }

    private fun createNotificationChannel() {
        // Create the NotificationChannel, but only on API 26+
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                    DOWNLOAD_CHANNEL_ID,
                    "Downloading photos",
                    NotificationManager.IMPORTANCE_DEFAULT)

            val notificationManager: NotificationManager =
                    getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }
}