//
//  KKMessages.swift
//  KKMessages
//
//  Created by  Kalpesh on 04/05/25.
//

import Foundation
import UIKit

typealias Handler = () -> Void
typealias Completion = (Bool) -> Void

enum KKAlertType: Int {
    case success = 0
    case error = 1
    case warning = 2
    case info = 3
    case custom = 4
}

enum KKAlertPosition: Int {
    case top = 0
    case bottom = 1
}

class KKMessages: UIViewController {
    
    var alertViewBackgroundColor: UIColor?
    var titleLabelTextColor: UIColor?
    var messageLabelTextColor: UIColor?
    var titleLabelFont: UIFont?
    var messageLabelFont: UIFont?
    
    private var titleString: String?
    private var messageString: String?
    private var iconImage: UIImage?
    private var hideOnSwipe: Bool = false
    private var hideOnTap: Bool = false
    private var alertPosition: KKAlertPosition = .bottom
    private var duration: TimeInterval = 0
    private var messageLabelHeight: CGFloat = 0
    private var titleLabelHeight: CGFloat = 0
    private var alertViewHeight: CGFloat = 0
    private var iconImageSize: CGSize = .zero
    private var handler: Handler?
    private var completion: Completion?
    
    private static var currentAlertArray: [KKMessages] = []
    
    static func showCardAlert(title: String, message: String?, duration: TimeInterval, hideOnSwipe: Bool, hideOnTap: Bool, alertType: KKAlertType, alertPosition: KKAlertPosition, didHide: @escaping Completion) -> KKMessages {
        
        let alert = KKMessages(cardAlertWithTitle: title, message: message, iconImage: nil, duration: duration, hideOnSwipe: hideOnSwipe, hideOnTap: hideOnTap, alertType: alertType, alertPosition: alertPosition)
        
        alert.show(handler: nil, didHide: didHide)
        
        return alert
    }
    
    static func cardAlertWithTitle(title: String, message: String?, iconImage: UIImage?, duration: TimeInterval, hideOnSwipe: Bool, hideOnTap: Bool, alertType: KKAlertType, alertPosition: KKAlertPosition) -> KKMessages {
        return KKMessages(cardAlertWithTitle: title, message: message, iconImage: iconImage, duration: duration, hideOnSwipe: hideOnSwipe, hideOnTap: hideOnTap, alertType: alertType, alertPosition: alertPosition)
    }
    
    private init(cardAlertWithTitle title: String, message: String?, iconImage: UIImage?, duration: TimeInterval, hideOnSwipe: Bool, hideOnTap: Bool, alertType: KKAlertType, alertPosition: KKAlertPosition) {
        super.init(nibName: nil, bundle: nil)
        
        self.titleString = title
        self.messageString = message
        self.duration = duration
        self.hideOnSwipe = hideOnSwipe
        self.hideOnTap = hideOnTap
        self.alertPosition = alertPosition
//        self.iconImage = iconImage
        self.configureViewForAlertType(alertType)
        self.iconImageSize = iconImage == nil ? CGSize.zero : CGSize(width: 35, height: 35)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageLabelHeight = ceil(preferredHeightForMessageString(messageString))
        titleLabelHeight = ceil(preferredHeightForTitleString(titleString))
        alertViewHeight = 8 + titleLabelHeight + 3 + messageLabelHeight + 8
        
        if alertViewHeight < 51 {
            alertViewHeight = 51
        }
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        var alertYPosition = screenHeight - alertViewHeight - screenHeight
        
        if alertPosition == .bottom {
            alertYPosition = screenHeight + alertViewHeight
        }
        
        view.backgroundColor = .clear
        view.frame = CGRect(x: 4, y: alertYPosition, width: screenWidth - 16, height: alertViewHeight)
        view.alpha = 0.7
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        constructAlertCardView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange(_:)), name: UIDevice.orientationDidChangeNotification, object: nil)
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
    }
    
    @objc private func deviceOrientationDidChange(_ notification: Notification) {
        hide(animated: true)
    }
    
    private func configureViewForAlertType(_ alertType: KKAlertType) {
        switch alertType {
        case .success:
            alertViewBackgroundColor = Constant.Colors.toastSuccessBG
            titleLabelTextColor = UIColor.white
            messageLabelTextColor = UIColor.white
            titleLabelFont = UIFont.boldSystemFont(ofSize: 16)
            messageLabelFont = UIFont.systemFont(ofSize: 14)
            iconImage = UIImage(systemName: "checkmark.circle.fill")
        case .error:
            alertViewBackgroundColor = Constant.Colors.toastErrorBG
            titleLabelTextColor = UIColor.white
            messageLabelTextColor = UIColor.white
            titleLabelFont = UIFont.boldSystemFont(ofSize: 16)
            messageLabelFont = UIFont.systemFont(ofSize: 14)
            iconImage = UIImage(systemName: "exclamationmark.triangle.fill")
        case .warning:
            alertViewBackgroundColor = Constant.Colors.toastWarningBG
            titleLabelTextColor = UIColor.white
            messageLabelTextColor = UIColor.white
            titleLabelFont = UIFont.boldSystemFont(ofSize: 16)
            messageLabelFont = UIFont.systemFont(ofSize: 14)
            iconImage = UIImage(systemName: "exclamationmark.circle.fill")
        case .info:
            alertViewBackgroundColor = Constant.Colors.toastInfoBG
            titleLabelTextColor = UIColor.white
            messageLabelTextColor = UIColor.white
            titleLabelFont = UIFont.boldSystemFont(ofSize: 16)
            messageLabelFont = UIFont.systemFont(ofSize: 14)
            iconImage = UIImage(systemName: "info.circle.fill")
        case .custom:
            alertViewBackgroundColor = Constant.Colors.toastCustomBG
            titleLabelTextColor = UIColor.white
            messageLabelTextColor = UIColor.white
            titleLabelFont = UIFont.boldSystemFont(ofSize: 16)
            messageLabelFont = UIFont.systemFont(ofSize: 14)
            iconImage = UIImage(systemName: "star.circle.fill")
        }
    }
    
    private func constructAlertCardView() {
        let alertView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        alertView.backgroundColor = alertViewBackgroundColor
        view.addSubview(alertView)
        
        let iconImageView = UIImageView(frame: CGRect(x: 8, y: (alertViewHeight - iconImageSize.height) / 2, width: iconImageSize.width, height: iconImageSize.height))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = iconImage
        alertView.addSubview(iconImageView)
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 16 + iconImageSize.width, y: 8, width: view.frame.size.width - 32 - iconImageSize.width, height: titleLabelHeight)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.textColor = titleLabelTextColor
        titleLabel.font = titleLabelFont
        titleLabel.text = titleString
        alertView.addSubview(titleLabel)
        
        let messageLabel = UILabel()
        messageLabel.frame = CGRect(x: 16 + iconImageSize.width, y: 8 + titleLabelHeight + 3, width: view.frame.size.width - 32 - iconImageSize.width, height: messageLabelHeight)
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.textAlignment = .left
        messageLabel.numberOfLines = 0
        messageLabel.textColor = messageLabelTextColor
        messageLabel.font = messageLabelFont
        messageLabel.text = messageString
        alertView.addSubview(messageLabel)
        
        if hideOnSwipe {
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(gestureAction))
            swipeGesture.direction = .left
            alertView.addGestureRecognizer(swipeGesture)
        }
        
        if hideOnTap {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureActionWithHandler))
            alertView.addGestureRecognizer(tapGesture)
        }
    }
    
    func show(handler: Handler?, didHide: Completion?) {
        if let handler = handler {
            self.handler = handler
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureActionWithHandler))
            view.addGestureRecognizer(tapGesture)
        }
        
        if let didHide = didHide {
            self.completion = didHide
        }
        
        DispatchQueue.main.async {
            self.showInMain()
        }
    }
    
    private func showInMain() {
        if !KKMessages.currentAlertArray.isEmpty {
            DispatchQueue.main.async {
                self.hide(animated: true)
            }
        }
        
        // Ensure the alert is added to the correct window
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.addSubview(self.view)
            }
        }
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        // Adjust Y position based on the alert position
        var alertYPosition: CGFloat = 20
        
        // Use safe area insets for positioning the alert after the safe area
        let topSafeAreaInset = self.view.safeAreaInsets.top
        let bottomSafeAreaInset = self.view.safeAreaInsets.bottom
        
        if self.alertPosition == .bottom {
            alertYPosition = screenHeight - self.alertViewHeight - bottomSafeAreaInset - 10
        } else if self.alertPosition == .top {
            alertYPosition = topSafeAreaInset + 10 // Start just below the status bar area
        }
        
        print("alertYPosition before adjustment: \(alertYPosition)")
        
        // Handle edge cases for certain devices (e.g., iPhone X)
        if UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.size.height == 2436 {
            alertYPosition += self.alertPosition == .bottom ? -30 : 30
        }
        
        print("alertYPosition after adjustment: \(alertYPosition)")
        
        // Make sure the view frame is correctly set
        self.view.frame = CGRect(x: 4, y: alertYPosition, width: screenWidth - 16, height: self.alertViewHeight)
        
        // Debugging the frame of the view
        print("Frame of alert view: \(self.view.frame)")
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            // Final animation to display the alert
            self.view.frame = CGRect(x: 4, y: alertYPosition, width: screenWidth - 16, height: self.alertViewHeight)
            self.view.alpha = 1
        }) { finished in
            self.view.frame = CGRect(x: 4, y: alertYPosition, width: screenWidth - 16, height: self.alertViewHeight)
            self.view.alpha = 1
        }
        
        KKMessages.currentAlertArray.append(self)
        
        if duration > 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.hide(animated: false)
            }
        }
    }
    
    
    @objc private func gestureAction() {
        hide(animated: true)
    }
    
    @objc private func gestureActionWithHandler() {
        handler?()
        hide(animated: true)
    }
    
    private func hide(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.alpha = 0
                self.view.frame.origin.y -= self.view.frame.height
            }) { _ in
                self.view.removeFromSuperview()
                KKMessages.currentAlertArray.removeAll { $0 == self }
            }
        } else {
            view.removeFromSuperview()
            KKMessages.currentAlertArray.removeAll { $0 == self }
        }
        
        completion?(true)
    }
    
    private func preferredHeightForTitleString(_ title: String?) -> CGFloat {
        guard let title = title else { return 0 }
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.font = titleLabelFont
        titleLabel.text = title
        
        let size = titleLabel.sizeThatFits(CGSize(width: view.frame.size.width - 32 - iconImageSize.width, height: CGFloat.greatestFiniteMagnitude))
        return size.height
    }
    
    private func preferredHeightForMessageString(_ message: String?) -> CGFloat {
        guard let message = message else { return 0 }
        
        let messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.font = messageLabelFont
        messageLabel.text = message
        
        let size = messageLabel.sizeThatFits(CGSize(width: view.frame.size.width - 32 - iconImageSize.width, height: CGFloat.greatestFiniteMagnitude))
        return size.height
    }
}
