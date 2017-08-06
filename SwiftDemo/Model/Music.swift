//
//  Music.swift
//  SwiftDemo
//
//  Created by picomax on 2017. 7. 28..
//  Copyright © 2017년 Surfline. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct Music {
    let wrapperType: String
    let kind: String
    let artistId: String
    let collectionId: String
    let trackId: String
    let artistName: String
    let collectionName: String
    let trackName: String
    let collectionCensoredName: String
    let trackCensoredName: String
    let artistViewUrl: String
    let collectionViewUrl: String
    let trackViewUrl: String
    let previewUrl: String
    let artworkUrl30: String
    let artworkUrl60: String
    let artworkUrl100: String
    let collectionPrice: String
    let trackPrice: String
    let releaseDate: String
    let collectionExplicitness: String
    let trackExplicitness: String
    let discCount: String
    let discNumber: String
    let trackCount: String
    let trackNumber: String
    let trackTimeMillis: String
    let country: String
    let currency: String
    let primaryGenreName: String
    let isStreamable: String
    
    init(json: JSON) {
        wrapperType = json["wrapperType"].stringValue
        kind = json["kind"].stringValue
        artistId = json["artistId"].stringValue
        collectionId = json["collectionId"].stringValue
        trackId = json["trackId"].stringValue
        artistName = json["artistName"].stringValue
        collectionName = json["collectionName"].stringValue
        trackName = json["trackName"].stringValue
        collectionCensoredName = json["collectionCensoredName"].stringValue
        trackCensoredName = json["trackCensoredName"].stringValue
        artistViewUrl = json["artistViewUrl"].stringValue
        collectionViewUrl = json["collectionViewUrl"].stringValue
        trackViewUrl = json["trackViewUrl"].stringValue
        previewUrl = json["previewUrl"].stringValue
        artworkUrl30 = json["artworkUrl30"].stringValue
        artworkUrl60 = json["artworkUrl60"].stringValue
        artworkUrl100 = json["artworkUrl100"].stringValue
        collectionPrice = json["collectionPrice"].stringValue
        trackPrice = json["trackPrice"].stringValue
        releaseDate = json["releaseDate"].stringValue
        collectionExplicitness = json["collectionExplicitness"].stringValue
        trackExplicitness = json["trackExplicitness"].stringValue
        discCount = json["discCount"].stringValue
        discNumber = json["discNumber"].stringValue
        trackCount = json["trackCount"].stringValue
        trackNumber = json["trackNumber"].stringValue
        trackTimeMillis = json["trackTimeMillis"].stringValue
        country = json["country"].stringValue
        currency = json["currency"].stringValue
        primaryGenreName = json["primaryGenreName"].stringValue
        isStreamable = json["isStreamable"].stringValue
    }
}

extension Music {
    @discardableResult
    static func requestMusic(term: String, callback: @escaping (_ error: NSError?, _ muscis: [Music]?) -> Void) -> URLSessionTask? {
        let router = SDRouter.music(term: term)
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
                //let m = Music.init(json: json)
                //let m = (array?.filter({ $0.string != nil }).map({ $0.string! }))!
                var result: [Music] = []
                for object in array {
                    let m = Music(json: object)
                    result.append(m)
                }
                callback(nil, result)
            }
        })
    }
}


