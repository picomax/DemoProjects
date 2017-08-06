//
//  TVShow.swift
//  SwiftDemo
//
//  Created by picomax on 2017. 7. 28..
//  Copyright © 2017년 Surfline. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct TVShow {
    let wrapperType: String
    let collectionType: String
    let artistId: String
    let collectionId: String
    let artistName: String
    let collectionName: String
    let collectionCensoredName: String
    let artistViewUrl: String
    let collectionViewUrl: String
    let artworkUrl60: String
    let artworkUrl100: String
    let collectionPrice: String
    let collectionHdPrice: String
    let collectionExplicitness: String
    let contentAdvisoryRating: String
    let trackCount: String
    let copyright: String
    let country: String
    let currency: String
    let releaseDate: String
    let primaryGenreName: String
    let longDescription: String
    
    init(json: JSON) {
        wrapperType = json["wrapperType"].stringValue
        collectionType = json["collectionType"].stringValue
        artistId = json["artistId"].stringValue
        collectionId = json["collectionId"].stringValue
        artistName = json["artistName"].stringValue
        collectionName = json["collectionName"].stringValue
        collectionCensoredName = json["collectionCensoredName"].stringValue
        artistViewUrl = json["artistViewUrl"].stringValue
        collectionViewUrl = json["collectionViewUrl"].stringValue
        artworkUrl60 = json["artworkUrl60"].stringValue
        artworkUrl100 = json["artworkUrl100"].stringValue
        collectionPrice = json["collectionPrice"].stringValue
        collectionHdPrice = json["collectionHdPrice"].stringValue
        collectionExplicitness = json["collectionExplicitness"].stringValue
        contentAdvisoryRating = json["contentAdvisoryRating"].stringValue
        trackCount = json["trackCount"].stringValue
        copyright = json["copyright"].stringValue
        country = json["country"].stringValue
        currency = json["currency"].stringValue
        releaseDate = json["releaseDate"].stringValue
        primaryGenreName = json["primaryGenreName"].stringValue
        longDescription = json["longDescription"].stringValue
    }
}

extension TVShow {
    @discardableResult
    static func requestTVShow(term: String, callback: @escaping (_ error: NSError?, _ tvshows: [TVShow]?) -> Void) -> URLSessionTask? {
        let router = SDRouter.tvshow(term: term)
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
                var result: [TVShow] = []
                for object in array {
                    let m = TVShow(json: object)
                    result.append(m)
                }
                callback(nil, result)
            }
        })
    }
}

