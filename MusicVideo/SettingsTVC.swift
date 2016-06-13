//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by FOI on 13/06/16.
//  Copyright © 2016 Darijan Vertovsek. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {

    @IBOutlet weak var aboutDisplay: UILabel!
    
    @IBOutlet weak var feedBackDisplay: UILabel!
    
    @IBOutlet weak var securityDisplay: UILabel!
    
    @IBOutlet weak var touchID: UISwitch!
    
    @IBOutlet weak var bestImageDisplay: UILabel!
    
    @IBOutlet weak var APICnt: UILabel!
    
    @IBOutlet weak var sliderCnt: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.alwaysBounceVertical = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

    func preferredFontChange(){
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedBackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    }

    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
      /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
