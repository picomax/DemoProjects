//
//  Ebook.swift
//  SwiftDemo
//
//  Created by picomax on 2017. 7. 28..
//  Copyright © 2017년 Surfline. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct Ebook {
    let trackCensoredName: String
    let artistViewUrl: String
    let trackViewUrl: String
    let artworkUrl60: String
    let artworkUrl100: String
    let fileSizeBytes: String
    let currency: String
    let artistId: String
    let artistName: String
    let genres: [String]
    let kind: String
    let price: String
    let description: String
    let trackId: String
    let trackName: String
    let releaseDate: String
    let formattedPrice: String
    let artistIds: [String]
    let genreIds: [String]
    let averageUserRating: String
    let userRatingCount: String
    
    init(json: JSON) {
        trackCensoredName = json["trackCensoredName"].stringValue
        artistViewUrl = json["artistViewUrl"].stringValue
        trackViewUrl = json["trackViewUrl"].stringValue
        artworkUrl60 = json["artworkUrl60"].stringValue
        artworkUrl100 = json["artworkUrl100"].stringValue
        fileSizeBytes = json["fileSizeBytes"].stringValue
        currency = json["currency"].stringValue
        artistId = json["artistId"].stringValue
        artistName = json["artistName"].stringValue
        //genres = json["genres"].arrayValue
        genres = (json["genres"].array?.filter({ $0.string != nil }).map({ $0.string! }))!
        kind = json["kind"].stringValue
        price = json["price"].stringValue
        description = json["description"].stringValue
        trackId = json["trackId"].stringValue
        trackName = json["trackName"].stringValue
        releaseDate = json["releaseDate"].stringValue
        formattedPrice = json["formattedPrice"].stringValue
        //artistIds = json["artistIds"].arrayValue
        artistIds = (json["artistIds"].array?.filter({ $0.string != nil }).map({ $0.string! }))!
        //genreIds = json["genreIds"].arrayValue
        genreIds = (json["genreIds"].array?.filter({ $0.string != nil }).map({ $0.string! }))!
        averageUserRating = json["averageUserRating"].stringValue
        userRatingCount = json["userRatingCount"].stringValue
    }
}

extension Ebook {
    @discardableResult
    static func requestEbook(term: String, callback: @escaping (_ error: NSError?, _ ebooks: [Ebook]?) -> Void) -> URLSessionTask? {
        let router = SDRouter.ebook(term: term)
        return SessionManager.shared.requestSearch(router: router, callback: { (response) in
            switch response.result {
            case .failure(let error):
                dLog(error)
                callback(error as NSError, nil)
            case .success(let value):
                let json = JSON(value)
                //resultCount
                //results
                let array = json["results"].arrayValue
                var result: [Ebook] = []
                for object in array {
                    let m = Ebook(json: object)
                    result.append(m)
                }
                callback(nil, result)
            }
        })
    }
}


