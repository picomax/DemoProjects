//
//  Movie.swift
//  SwiftDemo
//
//  Created by picomax on 2017. 7. 28..
//  Copyright © 2017년 Surfline. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct Movie {
    let wrapperType: String
    let kind: String
    let collectionId: String
    let trackId: String
    let artistName: String
    let collectionName: String
    let trackName: String
    let collectionCensoredName: String
    let trackCensoredName: String
    let collectionArtistId: String
    let collectionArtistViewUrl: String
    let collectionViewUrl: String
    let trackViewUrl: String
    let previewUrl: String
    let artworkUrl30: String
    let artworkUrl60: String
    let artworkUrl100: String
    let collectionPrice: String
    let trackPrice: String
    let trackRentalPrice: String
    let collectionHdPrice: String
    let trackHdPrice: String
    let trackHdRentalPrice: String
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
    let contentAdvisoryRating: String
    let hasITunesExtras: String
    
    init(json: JSON) {
        wrapperType = json["wrapperType"].stringValue
        kind = json["kind"].stringValue
        collectionId = json["collectionId"].stringValue
        trackId = json["trackId"].stringValue
        artistName = json["artistName"].stringValue
        collectionName = json["collectionName"].stringValue
        trackName = json["trackName"].stringValue
        collectionCensoredName = json["collectionCensoredName"].stringValue
        trackCensoredName = json["trackCensoredName"].stringValue
        collectionArtistId = json["collectionArtistId"].stringValue
        collectionArtistViewUrl = json["collectionArtistViewUrl"].stringValue
        collectionViewUrl = json["collectionViewUrl"].stringValue
        trackViewUrl = json["trackViewUrl"].stringValue
        previewUrl = json["previewUrl"].stringValue
        artworkUrl30 = json["artworkUrl30"].stringValue
        artworkUrl60 = json["artworkUrl60"].stringValue
        artworkUrl100 = json["artworkUrl100"].stringValue
        collectionPrice = json["collectionPrice"].stringValue
        trackPrice = json["trackPrice"].stringValue
        trackRentalPrice = json["trackRentalPrice"].stringValue
        collectionHdPrice = json["collectionHdPrice"].stringValue
        trackHdPrice = json["trackHdPrice"].stringValue
        trackHdRentalPrice = json["trackHdRentalPrice"].stringValue
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
        contentAdvisoryRating = json["contentAdvisoryRating"].stringValue
        hasITunesExtras = json["hasITunesExtras"].stringValue
    }
}

extension Movie {
    @discardableResult
    static func requestMovie(term: String, callback: @escaping (_ error: NSError?, _ movies: [Movie]?) -> Void) -> URLSessionTask? {
        let router = SDRouter.movie(term: term)
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
                var result: [Movie] = []
                for object in array {
                    let m = Movie(json: object)
                    result.append(m)
                }
                callback(nil, result)
            }
        })
    }
}


