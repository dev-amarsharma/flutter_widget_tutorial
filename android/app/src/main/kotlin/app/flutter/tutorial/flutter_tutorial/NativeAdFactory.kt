package app.flutter.tutorial.flutter_tutorial

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.RatingBar
import android.widget.TextView
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.NativeAdFactory as GMANativeAdFactory

class NativeAdFactory(private val context: Context) : GMANativeAdFactory {

    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: Map<String, Any>?,
    ): NativeAdView {
        val adView = LayoutInflater.from(context)
            .inflate(R.layout.native_ad, null) as NativeAdView

        with(adView) {
            headlineView = findViewById<TextView>(R.id.ad_headline).also {
                it.text = nativeAd.headline
            }

            bodyView = findViewById<TextView>(R.id.ad_body).also {
                val body = nativeAd.body
                it.text = body
                it.visibility = if (body != null) View.VISIBLE else View.GONE
            }

            callToActionView = findViewById<Button>(R.id.ad_call_to_action).also {
                val cta = nativeAd.callToAction
                it.text = cta
                it.visibility = if (cta != null) View.VISIBLE else View.GONE
            }

            iconView = findViewById<ImageView>(R.id.ad_icon).also {
                val icon = nativeAd.icon
                if (icon != null) {
                    it.setImageDrawable(icon.drawable)
                    it.visibility = View.VISIBLE
                } else {
                    it.visibility = View.GONE
                }
            }

            starRatingView = findViewById<RatingBar>(R.id.ad_stars).also {
                val rating = nativeAd.starRating
                if (rating != null) {
                    it.rating = rating.toFloat()
                    it.visibility = View.VISIBLE
                } else {
                    it.visibility = View.GONE
                }
            }

            advertiserView = findViewById<TextView>(R.id.ad_advertiser).also {
                val advertiser = nativeAd.advertiser
                it.text = advertiser
                it.visibility = if (advertiser != null) View.VISIBLE else View.GONE
            }

            mediaView = findViewById<MediaView>(R.id.ad_media)

            setNativeAd(nativeAd)
        }

        return adView
    }
}
