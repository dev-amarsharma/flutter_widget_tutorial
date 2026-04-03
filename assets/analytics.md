# Analytics

## Overview
Analytics helps you understand how people actually use your app. In Android apps, the most common official stack is Google Analytics for Firebase, which lets you log events, attach parameters, and analyze engagement and behavior in the Firebase console.

Analytics is useful for answering questions like:

- Which screens are opened most often?
- How many users complete onboarding?
- Which feature is used after a push notification?
- Where do users drop out of a purchase or sign-in flow?

## Core concepts
According to Firebase Analytics docs:

- An event is a meaningful action in your app, such as `login`, `purchase`, or `select_item`.
- Event parameters add detail, such as item ID, screen name, or category.
- User properties describe user segments, such as subscription tier or preferred language.
- Audiences group users based on events or properties so you can analyze or target them later.

## Android usage
Typical Android code:

```kotlin
val analytics = FirebaseAnalytics.getInstance(context)

val bundle = Bundle().apply {
  putString(FirebaseAnalytics.Param.ITEM_ID, "sku_123")
  putString(FirebaseAnalytics.Param.ITEM_NAME, "Premium Upgrade")
}

analytics.logEvent(FirebaseAnalytics.Event.SELECT_ITEM, bundle)
```

This logs a structured event with parameters instead of a vague text message.

## What to track
Good analytics events are:

- tied to meaningful product actions
- named consistently
- limited to data that helps decisions
- careful about privacy and consent requirements

Examples:

- onboarding started and completed
- search submitted
- article opened
- purchase completed
- settings changed

## Best practices
- Track a small set of high-value events first.
- Use consistent naming conventions for events and parameters.
- Prefer meaningful parameters over many loosely defined events.
- Avoid sending sensitive personal data in analytics payloads.
- Align analytics with product questions, not just engineering curiosity.

## Common mistakes
- Logging too many low-value events.
- Using inconsistent event names across screens.
- Sending raw personally identifiable information.
- Treating analytics as a debugging log instead of product instrumentation.

## Practice
1. Define 5 events for a real app flow such as sign-in or checkout.
2. Add 2 to 3 parameters to each event.
3. Decide which metrics would prove the feature is successful.

## References
- Firebase Analytics overview: https://firebase.google.com/docs/analytics
- Firebase Analytics Android API: https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics
