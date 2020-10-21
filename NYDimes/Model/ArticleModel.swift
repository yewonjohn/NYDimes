//
//  ArticleModel.swift
//  NYDimes
//
//  Created by John Kim on 10/15/20.
//

import Foundation
import SwiftyJSON

//Article Model for API fetching
struct ArticleModel {
    
    var url: String?
    var id: Int?
    var source: String?
    var published: String?
    var updated: String?
    var section: String?
    var author: String?
    var title: String?
    var abstract: String?
    var image: MediaModel?
    var documentId: String?
    
    init(json:JSON) {
        self.url = json["url"].stringValue
        self.id = json["id"].intValue
        self.source = json["source"].stringValue
        self.published = json["published_date"].stringValue
        self.updated = json["updated"].stringValue
        self.section = json["section"].stringValue
        self.author = json["byline"].stringValue
        self.title = json["title"].stringValue
        self.abstract = json["abstract"].stringValue
        
        //setting image here
        let media =  json["media"].arrayValue.map {$0["media-metadata"].arrayValue}
        var mediaMetadata = [JSON]()
        if(!media.isEmpty){
            mediaMetadata = media[0]
            let imageJSON = mediaMetadata[mediaMetadata.count-1]
            self.image = MediaModel(url: imageJSON["url"].stringValue, height: imageJSON["height"].intValue, width: imageJSON["width"].intValue)
        }
    }
    init(){}
}

struct MediaModel {
    var url: String?
    var height: Int?
    var width: Int?
}
