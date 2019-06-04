package me.wolszon.reddigram

import android.app.IntentService
import android.app.PendingIntent
import android.content.Intent
import android.graphics.Bitmap
import android.net.Uri
import android.os.Environment
import android.support.v4.app.NotificationCompat
import android.support.v4.app.NotificationManagerCompat
import me.wolszon.reddigram.ReddigramApplication.Companion.DOWNLOAD_CHANNEL_ID
import okhttp3.OkHttpClient
import okhttp3.Request
import java.io.File
import java.io.FileOutputStream
import java.lang.Exception
import android.graphics.BitmapFactory

class DownloadPhotoService : IntentService("DownloadPhotoService") {
    companion object {
        const val EXTRA_URL = "EXTRA_URL"
    }

    override fun onHandleIntent(intent: Intent?) {
        val notification = NotificationCompat.Builder(this, DOWNLOAD_CHANNEL_ID)
                .setSmallIcon(R.drawable.ic_file_download)
                .setContentTitle("Downloading photo...")
                .setProgress(0, 0, true)
                .build()
        startForeground(ReddigramApplication.newNotificationId, notification)

        val photoDownloadUrl = intent?.getStringExtra(EXTRA_URL) ?: ""
        val photoFile = createFile(photoDownloadUrl)

        downloadFile(photoDownloadUrl, photoFile)
    }

    private fun createFile(downloadUrl: String): File {
        val photoUri = Uri.parse(downloadUrl)
        val directory = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES).path

        val reddigramDirectory = File("$directory/Reddigram")
        reddigramDirectory.mkdir()

        val photoName = Regex("""(.*)\..*""").find(photoUri.lastPathSegment!!)!!.groupValues[1]
        return File(reddigramDirectory.path + "/" + photoName + ".jpg")
    }

    private fun downloadFile(url: String, target: File) {
        try {
            val request = Request.Builder().url(url).build()
            val response = OkHttpClient().newCall(request).execute()

            if (!response.isSuccessful) return error()

            target.createNewFile()
            val stream = FileOutputStream(target)

            val inputStream = response.body()!!.byteStream()
            val bitmap = BitmapFactory.decodeStream(inputStream)

            bitmap.compress(Bitmap.CompressFormat.JPEG, 100, stream)
            stream.close()

            success(target)
        } catch (e: Exception) {
            e.printStackTrace()

            error()
        }
    }

    private fun success(downloadedFile: File) {
        val builder = NotificationCompat.Builder(this, DOWNLOAD_CHANNEL_ID)
                .setSmallIcon(R.drawable.ic_file_download)
                .setContentTitle("Downloaded photo")
                .setContentText(downloadedFile.name)
                .setContentIntent(buildPhotoPendingIntent(downloadedFile))
                .setLargeIcon(BitmapFactory.decodeFile(downloadedFile.path))
                .setAutoCancel(true)

        NotificationManagerCompat.from(this).notify(ReddigramApplication.newNotificationId, builder.build())

        stopSelf()
    }

    private fun buildPhotoPendingIntent(downloadedFile: File): PendingIntent {
        val intent = Intent().apply {
            action = Intent.ACTION_VIEW
            data = Uri.parse("file://" + downloadedFile.absolutePath)
            type = "image/*"
        }

        return PendingIntent.getActivity(this, 0, intent, 0)
    }

    private fun error() {
        stopSelf()
    }
}
