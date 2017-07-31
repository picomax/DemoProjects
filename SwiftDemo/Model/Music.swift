//
//  Music.swift
//  SwiftDemo
//
//  Created by Ryan Han on 7/28/17.
//  Copyright © 2017 Surfline. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct Music {
    let id: String
    let name: String
    let singer: String
    
    init(json: JSON) {
        id = json["id"].stringValue
        name = json["name"].stringValue
        singer = json["singer"].stringValue
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
                let m = Music(json: json)
                callback(nil, [m])
            }
        })
    }
}
