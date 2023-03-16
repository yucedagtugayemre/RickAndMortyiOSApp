//
//  RMAPICacheManager.swift
//  RickAndMorty
//
//  Created by Tugay Emre Yucedag on 16.03.2023.
//

import Foundation

/// Manages in memory session scoped API caches
final class RMAPICacheManager {
    // API URL: Data
    
    private var cacheDictionary: [
        RMEndpoint : NSCache<NSString,NSData>
    ] = [:]
    
    
    
    private var cache = NSCache<NSString,NSData>()
    
    
    init (){
        setUpCache()
    }
    
    // MARK: - Public
    
    public func cachedResponse(for endPoint: RMEndpoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endPoint] , let url = url else {return nil}
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache(for endPoint: RMEndpoint, url: URL?, data: Data){
        guard let targetCache = cacheDictionary[endPoint] , let url = url else {return}
        let key = url.absoluteString as NSString
        return targetCache.setObject(data as NSData, forKey: key)
    }
    
    // MARK: - Private
    
    private func setUpCache() {
        RMEndpoint.allCases.forEach {
            cacheDictionary[$0] = NSCache<NSString,NSData>()
        }
    }
    
}
