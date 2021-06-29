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
    
    static func downloadImage(withUrl url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
        var downloadedImage: UIImage?
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            if downloadedImage != nil {
                cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
            }
            DispatchQueue.main.async {
                completion(downloadedImage)
            }
        }.resume()
    }
    static func getImage(withUrl url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(image)
        } else {
            downloadImage(withUrl: url, completion: completion)
        }
    }
}
