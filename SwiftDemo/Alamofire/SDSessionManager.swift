//
//  SDSessionManager.swift
//  SwiftDemo
//
//  Created by Ryan Han on 7/28/17.
//  Copyright © 2017 Surfline. All rights reserved.
//

import Alamofire
import Foundation

class SDSessionManager: Alamofire.SessionManager {
    static let shared: SDSessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = .useProtocolCachePolicy
        let manager = SDSessionManager(configuration: configuration)
        manager.configureURLCache()
        return manager
    }()
    
    fileprivate func configureURLCache() {
        let cacheSizeMemory = 1024 * 1024 * 1024; // 1024 MB
        let cacheSizeDisk = 1024 * 1024 * 1024; // 1024 MB
        let sharedCache = URLCache(memoryCapacity: cacheSizeMemory, diskCapacity: cacheSizeDisk, diskPath: "nsurlcache")
        URLCache.shared = sharedCache
    }
}

//MARK:- iTunes Search
enum SDRouter: URLConvertible {
    case movie(term: String)
    case tvshow(term: String)
    case music(term: String)
    case ebook(term: String)
    
    func asURL() throws -> URL {
        var urlComponent = URLComponents()
        urlComponent.host = "https://itunes.apple.com/"
        urlComponent.path = "search"
        
        var queryItems: [URLQueryItem] = []
        switch self {
        case .movie(let term):
            queryItems.append(URLQueryItem(name: "media", value: "movie"))
            queryItems.append(URLQueryItem(name: "entity", value: "movie"))
            queryItems.append(URLQueryItem(name: "term", value: term))
        case .tvshow(let term):
            queryItems.append(URLQueryItem(name: "media", value: "tvShow"))
            queryItems.append(URLQueryItem(name: "entity", value: "tvSeason"))
            queryItems.append(URLQueryItem(name: "term", value: term))
        case .music(let term):
            queryItems.append(URLQueryItem(name: "media", value: "music"))
            queryItems.append(URLQueryItem(name: "entity", value: "musicTrack"))
            queryItems.append(URLQueryItem(name: "term", value: term))
        case .ebook(let term):
            queryItems.append(URLQueryItem(name: "media", value: "ebook"))
            queryItems.append(URLQueryItem(name: "entity", value: "ebook"))
            queryItems.append(URLQueryItem(name: "term", value: term))
        }
        return urlComponent.url!
    }
}

extension SDSessionManager {
    func requestSearch(router: SDRouter, callback: @escaping (DataResponse<Any>) -> Void) -> URLSessionTask? {
        let request = SDSessionManager.shared.request(router)
        return request.task
    }
}
