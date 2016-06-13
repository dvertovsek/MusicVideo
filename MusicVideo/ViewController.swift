//
//  ViewController.swift
//  MusicVideo
//
//  Created by FOI on 13/06/16.
//  Copyright © 2016 Darijan Vertovsek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json",
            completion: didLoadData)
    }
    
    func didLoadData(videos: [Videos]){
        
        print(reachabilityStatus)
        
        self.videos = videos
        
        for(index,item) in videos.enumerate(){
            print("\(index) name = \(item.vName)")
        }
        
//        
//        for i in 0..<videos.count{
//            print("\(i) name = \(videos[i].vName)")
//        }
    }
    
}

