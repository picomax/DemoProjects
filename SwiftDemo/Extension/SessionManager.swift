//
//  SDSessionManager.swift
//  SwiftDemo
//
//  Created by Ryan Han on 7/28/17.
//  Copyright © 2017 Surfline. All rights reserved.
//

import Alamofire
import Foundation

extension SessionManager {
    static let shared: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = .useProtocolCachePolicy
        let manager = SessionManager(configuration: configuration)
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
        urlComponent.scheme = "https"
        urlComponent.host = "itunes.apple.com"
        urlComponent.path = "/search"
        
        switch self {
        case .movie(let term):
            urlComponent.queryItems = [URLQueryItem(name: "media", value: "movie"),
                                       URLQueryItem(name: "entity", value: "movie"),
                                       URLQueryItem(name: "term", value: term)]
        case .tvshow(let term):
            urlComponent.queryItems = [URLQueryItem(name: "media", value: "tvShow"),
                                       URLQueryItem(name: "entity", value: "tvSeason"),
                                       URLQueryItem(name: "term", value: term)]
        case .music(let term):
            urlComponent.queryItems = [URLQueryItem(name: "media", value: "music"),
                                       URLQueryItem(name: "entity", value: "musicTrack"),
                                       URLQueryItem(name: "term", value: term)]
        case .ebook(let term):
            urlComponent.queryItems = [URLQueryItem(name: "media", value: "ebook"),
                                       URLQueryItem(name: "entity", value: "ebook"),
                                       URLQueryItem(name: "term", value: term)]
        }
        return urlComponent.url!
    }
}

extension SessionManager {
    @discardableResult
    func requestSearch(router: SDRouter, callback: @escaping (DataResponse<Any>) -> Void) -> URLSessionTask? {
        let request = SessionManager.shared.request(router).responseJSON(completionHandler: callback)
        return request.task
    }
}
