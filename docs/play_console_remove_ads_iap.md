# Play Console: Set Up "Remove Ads" In-App Product

## Prerequisites
- App already published (at least as internal testing track) in Google Play Console
- App ID: `digimonk.app.htmljs`

---

## Steps

### 1. Open your app in Play Console
1. Go to [play.google.com/console](https://play.google.com/console)
2. Select **HTML JS Learning Hub** (package: `digimonk.app.htmljs`)

### 2. Navigate to In-App Products
1. In the left sidebar: **Monetize → In-app products**
2. Click **Create product**

### 3. Fill in the product details

| Field | Value |
|-------|-------|
| **Product ID** | `remove_ads` ← must match exactly |
| **Name** | Remove Ads |
| **Description** | Enjoy an ad-free experience. One-time purchase — no subscriptions. |
| **Status** | Active |

### 4. Set the price
1. Click **Add a price**
2. Set your base price (e.g. USD $1.99 or $2.99)
3. Click **Save** — Play Console auto-converts to other currencies

### 5. Save and activate
1. Click **Save** at the top right
2. Confirm the product status shows **Active** (not Draft)

---

## Verify the integration is wired correctly

The Flutter code already uses product ID `remove_ads` in:
```
lib/services/purchase_service.dart  →  const removeAdsProductId = 'remove_ads'
```

No code changes needed after completing the steps above.

---

## Testing before release
- Use a **test account** (Play Console → License testing → add your Gmail) to make purchases without being charged
- Or use `BillingClient` test product IDs during development (already handled — debug mode skips real purchases in ad SDKs)
