package me.wolszon.reddigram

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.webkit.CookieManager
import android.webkit.WebView

class OauthActivity : Activity() {
    private val webView by lazy { WebView(this) }
    private val clientId by lazy { intent.getStringExtra(CLIENT_ID_EXTRA) }

    companion object {
        const val CODE_EXTRA = "CODE"
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
                    "&response_type=code&state=x&scope=read+mysubreddits+vote+identity" +
                    "&redirect_uri=https://reddigram.wolszon.me/redirect&duration=permanent"

            loadUrl(url)
        }
    }

    inner class WebViewClient : android.webkit.WebViewClient() {
        override fun onPageFinished(view: WebView?, url: String?) {
            val uri = Uri.parse(url)
            if (uri.host?.contains("reddigram.wolszon.me") == true) {
                if (uri.queryParameterNames.contains("error")) {
                    // access_denied for example, on Disallow click
                    finish()
                }

                val resultIntent = Intent().apply {
                    putExtra(CODE_EXTRA, uri.getQueryParameter("code"))
                }
                setResult(RESULT_OK, resultIntent)
                finish()
            }

            super.onPageFinished(view, url)
        }
    }
}