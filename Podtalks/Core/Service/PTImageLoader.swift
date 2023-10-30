//
//  PTImageLoader.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 30/10/23.
//

import UIKit

// https://www.donnywals.com/efficiently-loading-images-in-table-views-and-collection-views/
class PTImageLoader {
    private var runningRequests: [UUID: URLSessionDataTask] = [:]
    private var loadedImages = [String: UIImage]()
    
    func loadImage(_ url: URL?, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        
        guard let url = url else { return nil }
        
        if let image = loadedImages[url.absoluteString] {
            completion(.success(image))
            return nil
        }
        
        let uuid = UUID()
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            defer {self.runningRequests.removeValue(forKey: uuid) }
            if let data = data, let image = UIImage(data: data) {
                self.loadedImages[url.absoluteString] = image
                completion(.success(image))
                return
            }
            guard let error = error else {
                // without an image or an error, we'll just ignore this for now
                // you could add your own special error cases for this scenario
                return
            }
            
            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
            
            // the request was cancelled, no need to call the callback
        }
        task.resume()
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
      runningRequests[uuid]?.cancel()
      runningRequests.removeValue(forKey: uuid)
    }
}
