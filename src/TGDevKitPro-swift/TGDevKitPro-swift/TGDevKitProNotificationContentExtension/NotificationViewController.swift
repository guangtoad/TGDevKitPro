//
//  NotificationViewController.swift
//  TGDevKitProNotificationContentExtension
//
//  Created by toad on 2025/6/10.
//

import Cocoa
import UserNotifications
import UserNotificationsUI

class NotificationViewController: NSViewController, UNNotificationContentExtension {

    @IBOutlet var label: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label.stringValue = notification.request.content.body
    }

}
