//
//  MovieModel.swift
//  NYDimes
//
//  Created by John Kim on 10/31/20.
//

import Foundation



struct MovieJSONResults : Decodable{
    var results : [MovieModel]?
}

struct MovieModel : Decodable{
    var display_title : String?
    var critics_pick: Int?
    var byline: String?
    var headline: String?
    var summary_short: String?
    var publication_date: String?
    var opening_date: String?
    var date_updated: String?
    var link: LinkModel?
    var multimedia: MultiMediaModel?
}

struct LinkModel : Decodable{
    var type: String?
    var url : String?
    var suggested_link_text: String?
}

struct MultiMediaModel : Decodable{
    var type: String?
    var src: String?
    var width: Int?
    var height: Int?
}


