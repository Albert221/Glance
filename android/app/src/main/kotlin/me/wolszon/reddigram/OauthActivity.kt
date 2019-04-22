package me.wolszon.reddigram

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.util.Log
import android.webkit.CookieManager
import android.webkit.WebResourceRequest
import android.webkit.WebResourceResponse
import android.webkit.WebView
import java.net.URLDecoder

class OauthActivity : Activity() {
    private val webView by lazy { WebView(this) }
    private val clientId by lazy { intent.getStringExtra(CLIENT_ID_EXTRA) }

    companion object {
        const val ACCESS_TOKEN_EXTRA = "ACCESS_TOKEN"
        private const val CLIENT_ID_EXTRA = "CLIENT_ID"

        fun createIntent(context: Context, clientId: String): Intent {
            return Intent(context, OauthActivity::class.java).apply {
                putExtra(CLIENT_ID_EXTRA, clientId)
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(webView)
        setupWebView()
    }

    @SuppressLint("SetJavaScriptEnabled")
    private fun setupWebView() {
        webView.apply {
            if (BuildConfig.DEBUG) {
                WebView.setWebContentsDebuggingEnabled(true)
            }

            val cookieManager = CookieManager.getInstance()
            cookieManager.setAcceptCookie(true)
            cookieManager.setAcceptThirdPartyCookies(webView, true)

            webViewClient = WebViewClient()

            val url = "https://www.reddit.com/api/v1/authorize?client_id=$clientId" +
                    "&response_type=token&state=x&scope=read+mysubreddits+vote+identity" +
                    "&redirect_uri=https://reddigram.wolszon.me/redirect"

            loadUrl(url)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        setResult(Activity.RESULT_CANCELED)
    }

    inner class WebViewClient : android.webkit.WebViewClient() {
        override fun onPageFinished(view: WebView?, url: String?) {
            val uri = Uri.parse(url)
            if (uri.host?.contains("reddigram.wolszon.me") == true) {
                val decodedData = URLDecoder.decode(uri.fragment, "UTF-8")

                val data = decodedData
                        .split('&')
                        .map { it.split('=') }
                        .map { it[0] to it[1] }
                        .toMap()

                val resultIntent = Intent().apply {
                    putExtra(ACCESS_TOKEN_EXTRA, data["access_token"])
                }
                setResult(Activity.RESULT_OK, resultIntent)
                finish()
            }

            super.onPageFinished(view, url)
        }
    }
}