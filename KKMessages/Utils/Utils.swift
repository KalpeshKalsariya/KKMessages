//
//  Utils.swift
//  KKMessageView
//
//  Created by  Kalpesh on 04/05/25.
//

import Foundation
import UIKit

enum ALERT_MESSAGE_TYPE {
    case SUCCESS
    case FAILURE
    case WARNING
}

struct Constant {
    
    //colorLiteral: RGB with Alpha
    struct Colors {
        static let toastSuccessBG = #colorLiteral(red: 0.1215686275, green: 0.6941176471, blue: 0.5411764706, alpha: 1) // Success Color
        static let toastErrorBG = #colorLiteral(red: 0.8823529412, green: 0.0, blue: 0.0, alpha: 1) // Error Color
        static let toastWarningBG = #colorLiteral(red: 1.0, green: 0.5254901961, blue: 0.0, alpha: 1) // Warning Color
        static let toastInfoBG = #colorLiteral(red: 0.2941176471, green: 0.4196078431, blue: 0.4784313725, alpha: 1) // Info Color
        static let toastCustomBG = #colorLiteral(red: 0.3764705882, green: 0.7215686275, blue: 0.9294117647, alpha: 1) // Custom Color
    }
}

enum AlertType {
    case success
    case failure
    case warning
    case info
    case custom
    
    // Computed properties to get the title for each case
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failure:
            return "Failure"
        case .warning:
            return "Warning"
        case .info:
            return "Information"
        case .custom:
            return "Custom Alert"
        }
    }
    
    // Computed properties to get the message for each case
    var message: String {
        switch self {
        case .success:
            return "Your action was successful!"
        case .failure:
            return "Something went wrong. Please try again."
        case .warning:
            return "This is a warning message. Please be cautious."
        case .info:
            return "This is an informational message."
        case .custom:
            return "This is a custom message."
        }
    }
}



func showAlertWithTitle(title: String, message: String, alert_type: AlertType = .info, alert_position: KKAlertPosition = .top) {
    let localizedTitle = NSLocalizedString(title, comment: "")
    let localizedMessage = NSLocalizedString(message, comment: "")
    
    switch alert_type {
    case .success:
        _ = KKMessages.showCardAlert(title: localizedTitle, message: localizedMessage, duration: 2.0, hideOnSwipe: true, hideOnTap: true, alertType: .success, alertPosition: alert_position, didHide: { finished in
            // Add any logic when the alert is hidden
        })
        
    case .failure:
        _ = KKMessages.showCardAlert(title: localizedTitle, message: localizedMessage, duration: 2.0, hideOnSwipe: true, hideOnTap: true, alertType: .error, alertPosition: alert_position, didHide: { finished in
            // Add any logic when the alert is hidden
        })
        
    case .warning:
        _ = KKMessages.showCardAlert(title: localizedTitle, message: localizedMessage, duration: 2.0, hideOnSwipe: true, hideOnTap: true, alertType: .warning, alertPosition: alert_position, didHide: { finished in
            // Add any logic when the alert is hidden
        })
    case .info:
        _ = KKMessages.showCardAlert(title: localizedTitle, message: localizedMessage, duration: 2.0, hideOnSwipe: true, hideOnTap: true, alertType: .info, alertPosition: alert_position, didHide: { finished in
            // Add any logic when the alert is hidden
        })
    case .custom:
        _ = KKMessages.showCardAlert(title: localizedTitle, message: localizedMessage, duration: 2.0, hideOnSwipe: true, hideOnTap: true, alertType: .custom, alertPosition: alert_position, didHide: { finished in
            // Add any logic when the alert is hidden
        })
    }
}

