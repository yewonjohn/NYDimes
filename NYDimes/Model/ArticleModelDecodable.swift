//
//  ArticleModelDecodable.swift
//  NYDimes
//
//  Created by John Kim on 10/20/20.
//

//Article Model for API fetching USING DECODABLE METHOD (for practice)

struct ArticleResults: Decodable{
    var results: [ArticleModelDecodable]?
}

struct ArticleModelDecodable:Decodable {
    
    var url: String?
    var id: Int?
    var source: String?
    var published: String?
    var updated: String?
    var section: String?
    var author: String?
    var title: String?
    var abstract: String?
    var media: [MediaModelDecoable]
    
}

//struct MediaMetaData: Decodable{
//    var media-metadata : [MediaModelDecoable]
//}

struct MediaModelDecoable: Decodable{
    var url: String?
    var height: Int?
    var width: Int?
}
