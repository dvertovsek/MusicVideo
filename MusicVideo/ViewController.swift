//
//  ViewController.swift
//  MusicVideo
//
//  Created by FOI on 13/06/16.
//  Copyright © 2016 Darijan Vertovsek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json",
            completion: didLoadData)
    }
    
    func didLoadData(result:String){
        let alert = UIAlertController(title: (result), message: nil, preferredStyle:  .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default) {
            action -> Void in
            //do sth you want
        
        }
        
        alert.addAction(okAction)
        self.presentViewController(alert, animated:  true, completion: nil)
    }
    
}

