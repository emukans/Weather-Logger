//
//  NotificationView.swift
//  Weather Logger
//
//  Created by Eduard Mukans on 16/04/2019.
//  Copyright © 2019 Eduards Mukans. All rights reserved.
//

import NotificationBannerSwift

class NotificationView {
    
    static func showSuccessAlert(message: String, title: String = "Success") {
        let banner = GrowingNotificationBanner(title: title, subtitle: message, style: .success)
        banner.duration = 3
        banner.show()
    }
    
    static func showFailureAlert(message: String, title: String = "Something went wrong") {
        let banner = GrowingNotificationBanner(title: title, subtitle: message, style: .danger)
        banner.duration = 3
        banner.show()
    }
    
}
