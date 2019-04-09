//
//  PayOptionViewController.swift
//  VendorManager
//
//  Created by NILESH_iOS on 28/03/19.
//  Copyright © 2019 iDev. All rights reserved.
//

import UIKit
import UserNotifications

class PayOptionViewController: UIViewController {

    @IBOutlet var lblAmt: UILabel!
    @IBOutlet var optionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // #1.1 - Create "the notification's category value--its type."
        let debitOverdraftNotifCategory = UNNotificationCategory(identifier: "debitOverdraftNotification", actions: [], intentIdentifiers: [], options: [])
        // #1.2 - Register the notification type.
        UNUserNotificationCenter.current().setNotificationCategories([debitOverdraftNotifCategory])
        
        fireLocalNotification()
    }
    
    @IBAction func quickPollAction(_ sender: UIButton) {
        let viewController = QuickPollViewController()
        viewController.view.bounds = view.bounds
        let nav = UINavigationController(rootViewController: viewController)
        self.present(nav, animated: true, completion: nil)
    }
    
    func fireLocalNotification() {
        // find out what are the user's notification preferences
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in

            // we're only going to create and schedule a notification
            // if the user has kept notifications authorized for this app
            guard settings.authorizationStatus == .authorized else { return }

            // create the content and style for the local notification
            let content = UNMutableNotificationContent()

            // #2.1 - "Assign a value to this property that matches the identifier
            // property of one of the UNNotificationCategory objects you
            // previously registered with your app."
            content.categoryIdentifier = "debitOverdraftNotification"

            // create the notification's content to be presented
            // to the user
            content.title = "DEBIT OVERDRAFT NOTICE!"
            content.subtitle = "Exceeded balance by $300.00."
            content.body = "One-time overdraft fee is $25. Should we cover transaction?"
            content.sound = UNNotificationSound.default

            //let url = Bundle.main.url(forResource: "work-briefcase", withExtension: "png")
            let url = Bundle.main.url(forResource: "florvideoplayback", withExtension: "mp4")
//            https://res.cloudinary.com/demo/image/upload/w_300,h_200,c_crop/sample.jpg
            
            //let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
            
            let attachment = try! UNNotificationAttachment(identifier: "image", url: url!, options: [:])
            
            
            //let imageData = NSData(contentsOf: url!)
            //guard let attachment = UNNotificationAttachment.create(imageFileIdentifier: "img.jpeg", data: imageData!, options: nil) else { return  }
            
            content.attachments = [attachment]
            
            // #2.2 - create a "trigger condition that causes a notification
            // to be delivered after the specified amount of time elapses";
            // deliver after 10 seconds
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

            // create a "request to schedule a local notification, which
            // includes the content of the notification and the trigger conditions for delivery"
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)

            // "Upon calling this method, the system begins tracking the
            // trigger conditions associated with your request. When the
            // trigger condition is met, the system delivers your notification."
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

        } // end getNotificationSettings
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

extension UNNotificationAttachment {
    /// Save the image to disk
    static func create(imageFileIdentifier: String, data: NSData, options: [NSObject : AnyObject]?) -> UNNotificationAttachment? {
        let fileManager = FileManager.default
        let tmpSubFolderName = ProcessInfo.processInfo.globallyUniqueString
        let tmpSubFolderURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(tmpSubFolderName, isDirectory: true)
        
        do {
            try fileManager.createDirectory(at: tmpSubFolderURL!, withIntermediateDirectories: true, attributes: nil)
            let fileURL = tmpSubFolderURL?.appendingPathComponent(imageFileIdentifier)
            try data.write(to: fileURL!, options: [])
            let imageAttachment = try UNNotificationAttachment.init(identifier: imageFileIdentifier, url: fileURL!, options: options)
            return imageAttachment
        } catch let error {
            print("error \(error)")
        }
        return nil
    }}
