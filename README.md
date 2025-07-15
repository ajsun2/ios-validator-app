# Validator App (ios) 

Built off Auth0 Swift Samples

## Requirements

- iOS 15+ / macOS 11+
- Xcode 14.x / 15.x

## App Features
### User Registration
Supports both Individual and Organization sign-up flows, each with distinct required fields and validation rules.

### Post-Signup Navigation
Upon successful registration, the app redirects the user to the Main view.

### Field Validation
Validation is enforced at the client side before form submission.

#### Individual Sign-Up 

    First*, Middle, Last Name* - Must be alpha only and may contain whitespace and the character '

    Password* - Must contain at least 12 characters, include an uppercase, lowercase, number, and special characters

    Phone* - Must match (xxx) xxx-xxxx format

    SSN - Must match xxx-xx-xxxx format

    Address* - Must be alphanumeric and may contain whitespace and dashes (-)

    City* - Must be alpha and may contain whitespace and dashes (-)

    State* - Should be a drop down menu

    Zipcode* — Must be exactly 5 numeric digits.


    * Required fields

#### Organization Sign-Up 

- Organization Name — Can be alphanumeric and may contain white and dashes (-)

- Organization Type - Drop down style <img width="312" height="318" alt="Screenshot 2025-07-15 at 12 38 33 PM" src="https://github.com/user-attachments/assets/c0c99acf-05b8-49e9-8e38-a40c8465d10d" />

- Address* - Must be alphanumeric and may contain whitespace and dashes (-)

- City* - Must be alpha and may contain whitespace and dashes (-)

- State* - Should be a drop down menu

- Zipcode* — Must be exactly 5 numeric digits.

- Organization Phone* - Must match (xxx) xxx-xxxx format

- Password* - Must contain at least 12 characters, include an uppercase, lowercase, number, and special characters

- Representative Usernam*e — Must be alphanumeric and may contain at most one special character (_ or @)

    * Required fields

Healthcare (Non-Profit and For-Profit)
- NPI - Must be 10 digits
- 
- FEIN - Must be 9 digits of xx-xxxxxxx format
- 
- State Tax ID - Can be alphanumeric and may contain the following characters - _ and . (Note: this field does not apply to WA, SD, TX, WY, NV, FL, AK)

Commerical (For-Profit)
##### NPI - Must match xxxxxxxxxx format, 10 digits long
##### FEIN - Must match xx-xxxxxxx format, 9 digits long
##### State Tax ID - Can be alphanumeric and may contain the following characters - _ and . (Note: this field does not apply to WA, SD, TX, WY, NV, FL, AK)

Federal Government
##### Organization Code - Up to 12 digits
##### Bureau Name - Must be alpha only and may contain whitespace

State and Municipal Government
##### FEIN - Must match xx-xxxxxxx format, 9 digits long
##### State Department ID - Up to 10 digits

Other (Non-Profit)
##### NPI - Must match xxxxxxxxxx format, 10 digits long
##### FEIN - Must match xx-xxxxxxx format, 9 digits long
##### State Tax ID - Can be alphanumeric and may contain the following characters - _ and . (Note: this field does not apply to WA, SD, TX, WY, NV, FL, AK)

### Address Verification
The app verifies the provided address with the backend address validation endpoint before allowing registration completion.

### Error Handling
Inline error messages are displayed next to fields when validation fails or if backend submission encounters an error.


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

If your iOS bundle identifier were `com.auth0.samples.SwiftSample` and your Auth0 Domain were `kevin-chen-development.us.auth0.com`, then this value would be:

```text
https://kevin-chen-development.us.auth0.com/ios/com.auth0.samples.SwiftSample/callback,
com.auth0.samples.SwiftSample://kevin-chen-development.us.auth0.com/ios/com.auth0.samples.SwiftSample/callback
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
