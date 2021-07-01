//
//  ImageService.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 25.06.2021.
//

import Foundation
import UIKit

class ImageService {
    private static let cache = NSCache<NSString, UIImage>()
    
    @discardableResult
    static func downloadImage(withUrl url: URL, completion: @escaping (_ image: UIImage?) -> Void) -> URLSessionTask {
        var downloadedImage: UIImage?
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            if downloadedImage != nil {
                cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
            }
            DispatchQueue.main.async {
                completion(downloadedImage)
            }
        }
        
        task.resume()
        
        return task
    }
    
    @discardableResult
    static func getImage(withUrl url: URL, completion: @escaping (_ image: UIImage?) -> Void) -> URLSessionTask? {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(image)
            return nil
        } else {
            return downloadImage(withUrl: url, completion: completion)
        }
    }
}
