# KKMessages - Custom Alert System for iOS

# Overview:
KKMessages is a custom alert system that can be used in iOS applications to display different types of alerts (`success`, `error`, `warning`, `info`, and `custom`) at the top or bottom of the screen. It allows for flexible configuration, such as setting the title, message, duration, swipe-to-dismiss behavior, and tap-to-dismiss behavior.

This alert system is designed to be easy to use and visually appealing, with smooth animations and customizable options for positioning, duration, and appearance.

# Features:
**Multiple Alert Types:** `Success`, `Error`, `Warning`, `Info`, and `Custom`.

**Customizable Appearance:** Allows you to configure the background color, text color, fonts, and icon for each alert type.

**Positioning:** You can choose to display the alert at the top or bottom of the screen.

**Dismissal Options:** Alerts can be dismissed on swipe or tap.

**Duration:** Set how long the alert should stay on screen before automatically hiding.

# Installation:
Simply add the files KKMessages.swift and Utils.swift to your project. No external dependencies are required.

# Usage:
**1. Show a Default Alert:**
To show an alert, simply call the showAlertWithTitle function. It allows you to specify the title, message, alert type, and position.

**Example usage:**
```swift
showAlertWithTitle(title: AlertType.success.title, message: AlertType.success.message, alert_type: .success)
```
This will show a success message at the top of the screen.

**2. Customizing Alerts:**
You can customize the alerts further by passing different parameters such as duration, hideOnSwipe, and hideOnTap.

**Example of a custom success alert:**
```swift
KKMessages.showCardAlert(
    title: "Success",
    message: "Your operation was successful!",
    duration: 2.0,
    hideOnSwipe: true,
    hideOnTap: true,
    alertType: .success,
    alertPosition: .top,
    didHide: { finished in
        // Logic when the alert is hidden
    }
)
```

**3. Dismissing Alerts:**
You can choose whether to dismiss alerts when the user taps or swipes the alert. The hideOnSwipe and hideOnTap parameters control this behavior.


# Code Explanation:
**1. KKMessages.swift:**

`KKAlertType:` Enum that defines the different types of alerts (Success, Error, Warning, Info, Custom).

`KKAlertPosition:` Enum that determines whether the alert will appear at the top or bottom of the screen.

`KKMessages:` The main class for managing and displaying alerts. It contains methods to configure and show the alert based on the provided parameters.

**Key Methods:**

`showCardAlert:` Displays an alert with the given parameters.

`constructAlertCardView:` Creates and customizes the view for the alert, including title, message, icon, and gestures.

`show:` This method animates the alert into view and handles multiple concurrent alerts by checking KKMessages.currentAlertArray.

`hide:` Dismisses the alert either with or without animation.

`preferredHeightForTitleString & preferredHeightForMessageString:` These methods calculate the height required for the title and message, ensuring that the layout is adjusted properly.

**2. Utils.swift:**

`AlertType:` Enum that holds default titles and messages for each type of alert (Success, Failure, Warning, etc.).

`Constant:` A structure holding the colors used for each alert type's background (Success, Error, Warning, etc.).

**3. ViewController.swift:**
Contains the UI for triggering the alert, which includes a button that shows an alert when pressed.


# KKMessages - Custom Alert System

## Alert Types - Screenshots

| Success Alert       | Error Alert       | Warning Alert      | Information Alert  | Custom Alert      |
|---------------------|-------------------|--------------------|--------------------|-------------------|
|![Simulator Screenshot - iPhone 16 Pro - 2025-05-04 at 13 32 22](https://github.com/user-attachments/assets/7088fc84-523d-4b1a-8321-9564a681a38d)|  ![Simulator Screenshot - iPhone 16 Pro - 2025-05-04 at 13 34 10](https://github.com/user-attachments/assets/b76cd8c4-68e7-435e-8088-697fb2c52875)|![Simulator Screenshot - iPhone 16 Pro - 2025-05-04 at 13 34 26](https://github.com/user-attachments/assets/353d613d-cf89-4c9b-aafc-b5d2b5497f54)|![Simulator Screenshot - iPhone 16 Pro - 2025-05-04 at 13 36 59](https://github.com/user-attachments/assets/6a5b19c5-35d6-4e9a-81f6-9f859da14db8)|![Simulator Screenshot - iPhone 16 Pro - 2025-05-04 at 13 37 14](https://github.com/user-attachments/assets/8a26cec5-ca39-43d2-a77f-71c1603d3717)|




# Customization:
`Alert Type:` The AlertType enum gives you the flexibility to customize the alert type (Success, Error, etc.). You can change the alert's background color, icon, and text color by customizing KKMessages.

`Position:` You can control where the alert appears (top or bottom) using the KKAlertPosition enum. The alertPosition parameter determines where the alert should appear on the screen.

`Duration:` The alert can automatically disappear after a specified duration, or you can keep it until the user taps or swipes it away.

`Swipe and Tap Gestures:` Alerts can be dismissed either by tapping on the alert or swiping it away. These behaviors are controlled by the hideOnSwipe and hideOnTap parameters.

# Conclusion:
KKMessages provides a simple yet powerful way to manage alerts in iOS applications. With its customizable features and smooth animations, it helps improve user experience by presenting alerts in an organized and visually appealing manner.


