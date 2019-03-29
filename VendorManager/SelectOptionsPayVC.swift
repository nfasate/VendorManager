//
//  SelectOptionsPayVC.swift
//  VendorManager
//
//  Created by NILESH_iOS on 28/03/19.
//  Copyright © 2019 iDev. All rights reserved.
//

import UIKit

class SelectOptionsPayVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



//        let content = UNMutableNotificationContent()
//        content.title = "Local Notifications"
//        content.subtitle =  "Good Morning"
//
//        content.body = "This is test local notification"
//
//        content.categoryIdentifier = "local"
//
//        let url = Bundle.main.url(forResource: "work-briefcase", withExtension: "png")
//
//        let attachment = try! UNNotificationAttachment(identifier: "image", url: url!, options: [:])
//        content.attachments = [attachment]
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
//
//        let request = UNNotificationRequest(identifier: "localNotification", content: content, trigger: trigger)
//
//        UNUserNotificationCenter.current().add(request) { (error) in
//            print(error)
//        }
