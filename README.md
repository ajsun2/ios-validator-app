# Validator App (ios) 

Built off Auth0 Swift Samples

## Requirements

- iOS 15+ / macOS 11+
- Xcode 14.x / 15.x

## Configuration

### 0. Open the project on Xcode

Ensure `Sample-01` is set as the root directory when opening the project in Xcode.

### 1. Configure the callback and logout URLs

Go to the settings page of your [Auth0 application](https://manage.auth0.com/#/applications/) and add the following URLs to **Allowed Callback URLs** and **Allowed Logout URLs**, depending on the app target you want to run –either **SwiftSample (iOS)** or **SwiftSample (macOS)**.

#### SwiftSample (iOS)

```text
https://YOUR_AUTH0_DOMAIN/ios/YOUR_BUNDLE_IDENTIFIER/callback,
YOUR_BUNDLE_IDENTIFIER://YOUR_AUTH0_DOMAIN/ios/YOUR_BUNDLE_IDENTIFIER/callback
```

<details>
  <summary>Example</summary>

If your iOS bundle identifier were `com.example.MyApp` and your Auth0 Domain were `example.us.auth0.com`, then this value would be:

```text
https://example.us.auth0.com/ios/com.example.MyApp/callback,
com.example.MyApp://example.us.auth0.com/ios/com.example.MyApp/callback
```
</details>

> [!IMPORTANT]
> Make sure that the Auth0 application type is **Native**. Otherwise, you might run into errors due to the different configurations of other application types.


### 2. Configure Auth0.swift

Rename the `Auth0.plist.example` file to `Auth0.plist`, and replace the `{CLIENT_ID}` and `{DOMAIN}` placeholders with the Client ID and domain of your Auth0 application.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>ClientId</key>
    <string>{CLIENT_ID}</string>
    <key>Domain</key>
    <string>{DOMAIN}</string>
</dict>
</plist>
```

## Navigating the Project Structure

### Sources/Network
Contains network-related logic, including address validation and form submission.

### Sources/Views
Contains app views and user interface components.

### Sources/Supporting Files
Contains supporting files such as `Validator.swift`, which handles client-side field validation logic.
