//
//  ImageLoader.swift
//  RickAndMorty
//
//  Created by Tugay Emre Yucedag on 7.03.2023.
//

import Foundation

final class RMImageLoader {
    static let shared = RMImageLoader()
    
    private var imageDataCache = NSCache<NSString,NSData>()
    
    private init() {}
    
    /// Get image content with URL
    /// - Parameters:
    ///   - url: Source URL
    ///   - completion: Callback
    public func downloadImage(_ url: URL, completion: @escaping (Result<Data,Error>) -> Void) {
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) {
            print("Reading from cahce: \(key)")
            completion(.success(data as Data)) // NSData  == Data || NSString == String
            return
        }
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            
            guard let data = data, error == nil  else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            let key = url.absoluteString as NSString
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
        }
        task.resume()
    }
}
