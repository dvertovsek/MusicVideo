//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by FOI on 13/06/16.
//  Copyright © 2016 Darijan Vertovsek. All rights reserved.
//

import Foundation

class Video {
    
    // Data Encapsulation
    private(set) var vRank:Int
    private(set) var vName:String
    private(set) var vRights:String
    private(set) var vPrice:String
    private(set) var vImageUrl:String
    private(set) var vArtist:String
    private(set) var vVideoUrl:String
    private(set) var vImid:String
    private(set) var vGenre:String
    private(set) var vLinkToiTunes:String
    private(set) var vReleaseDte:String

    //this var gets created from the UI
    var vImageData:NSData?
    
    init(vRank:Int, vName:String, vRights:String, vPrice:String,
        vImageUrl:String, vArtist:String, vVideoUrl:String, vImid:String,
        vGenre:String, vLinkToiTunes:String, vReleaseDte:String) {
            
            self.vRank = vRank
            self.vName = vName
            self.vRights = vRights
            self.vPrice = vPrice
            self.vImageUrl = vImageUrl
            self.vArtist = vArtist
            self.vVideoUrl = vVideoUrl
            self.vImid = vImid
            self.vGenre = vGenre
            self.vLinkToiTunes = vLinkToiTunes
            self.vReleaseDte = vReleaseDte
            
    }
}
    /*
    //Make a getter
    
    var vName: String {
        return _vName
    }
    
    var vRights: String {
        return _vRights
    }
    
    var vPrice: String {
        return _vPrice
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vArtist: String {
        return _vArtist
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    var vImid:String {
        return _vImid
    }
    
    var vGenre:String {
        return _vGenre
    }
    
    var vLinkToiTunes:String {
        return _vLinkToiTunes
    }
    
    var vReleaseDte:String {
        return _vReleaseDte
    }
    */


    /*
    init(data: JSONDictionary) {
        
        
        self.vName = ""
        self.vRights = ""
        self.vPrice = ""
        self.vImageUrl = ""
        self.vArtist = ""
        self.vVideoUrl = ""
        self.vImid = ""
        self.vGenre = ""
        self.vLinkToiTunes = ""
        self.vReleaseDte = ""
        
        // Video name
        if let imName = data["im:name"] as? JSONDictionary,
            label = imName["label"] as? String {
                vName = label
        }/*
        else
        {
            //You may not always get data back from the JSON - you may want to display message
            // element in the JSON is unexpected
            
            _vName = ""
        }*/
        
        // The Studio Name
        if let rightsDict = data["rights"] as? JSONDictionary,
            label = rightsDict["label"] as? String {
                vRights = label
        }
        
        // Price of Video
        
        if let imPrice = data["im:price"] as? JSONDictionary,
            label = imPrice["label"] as? String {
                vPrice = label
        }
        
        // The Video Image
        if let imImage = data["im:image"] as? JSONArray,
            image = imImage[2] as? JSONDictionary,
            label = image["label"] as? String {
                vImageUrl = label.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        }
        
        // The Artist Name
        if let imArtist = data["im:artist"] as? JSONDictionary,
            label = imArtist["label"] as? String {
                vArtist = label
        }
        
        //Video Url
        if let link = data["link"] as? JSONArray,
            vUrl = link[1] as? JSONDictionary,
            attributes = vUrl["attributes"] as? JSONDictionary,
            href = attributes["href"] as? String {
                vVideoUrl = href
        }
        
        // The Artist ID for iTunes Search API
        if let id = data["id"] as? JSONDictionary,
            attributes = id["attributes"] as? JSONDictionary,
            Imid = attributes["im:id"] as? String {
                vImid = Imid
        }
        
        // The Genre
        if let category = data["category"] as? JSONDictionary,
            attributes = category["attributes"] as? JSONDictionary,
            term = attributes["term"] as? String {
                vGenre = term
        }
        
        // Video Link to iTunes
        if let id = data["id"] as? JSONDictionary,
            label = id["label"] as? String {
                vLinkToiTunes = label
        }
        
        // The Release Date
        if let imReleaseDate = data["im:releaseDate"] as? JSONDictionary,
            attributes = imReleaseDate["attributes"] as? JSONDictionary,
            label = attributes["label"] as? String {
                vReleaseDte = label
        }
    }
*/