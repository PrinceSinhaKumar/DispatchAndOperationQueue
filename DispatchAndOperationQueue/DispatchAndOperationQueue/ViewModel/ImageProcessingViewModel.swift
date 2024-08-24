//
//  ImageProcessingViewModel.swift
//  DispatchAndOperationQueue
//
//  Created by  Prince Shrivastav on 24/08/24.
//

import Foundation
import UIKit

struct Album: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

class ImageProcessingViewModel {
    
    private var imageURLs: [String] = []
    private var uiImage: [UIImage] = []
    
    private let networkService: NetworkService
    init(networkService: NetworkService = NetworkManager()) {
        self.networkService = networkService
    }
    
    func getImageURLs() {
        networkService.request(HomeEndPoint.album, type: [Album].self, parameters: nil) { [weak self] result in
            switch result {
            case .success(let success):
                self?.imageURLs = success.map({$0.url})
                self?.concurrentImageDownload()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    //MARK: - If we don't use a semaphore in the image processing app, the following issues can occur:
    /*
     
     1. Resource Starvation: Without a semaphore, all images will be processed concurrently, which can lead to resource starvation. The app may consume too much memory, CPU, or other system resources, causing it to become unresponsive or even crash.

     2. Concurrency Issues: Without a semaphore, multiple images may be processed simultaneously, leading to concurrency issues. For example, if two images are being processed at the same time, they may overwrite each other's data or cause other unexpected behavior.

     3. Deadlocks: Without a semaphore, the app may experience deadlocks. A deadlock occurs when two or more threads are blocked, waiting for each other to release a resource. In the image processing app, a deadlock can occur if two threads are waiting for each other to finish processing an image.

     4. Performance Issues: Without a semaphore, the app may experience performance issues. Processing too many images concurrently can slow down the app and cause it to become unresponsive.

     5. Crashes: Without a semaphore, the app may crash due to excessive concurrent processing. If too many images are being processed at the same time, the app may run out of memory or experience other resource-related issues, leading to a crash.

     By using a semaphore, we can limit the number of concurrent image processing tasks, preventing these issues and ensuring the app remains responsive and stable.
     
     */
    
    private let semaphore = DispatchSemaphore(value: 10)
    private func semaphoreUseCase(url: String) {
        semaphore.wait()
        defer { semaphore.signal() }
        guard let url = URL(string: url) else { return }
        downloadImage(from: url) {[weak self] image in
            if let image {
                self?.uiImage.append(image)
                print("Images \(self?.uiImage.count ?? 0)")
            }
        }
        Thread.sleep(forTimeInterval: 2)
    }
    
    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error downloading image")
                completion(nil)
                return
            }
            guard let image = UIImage(data: data) else {
                print("Error creating image")
                completion(nil)
                return
            }
            
            completion(image)
        }.resume()
    }
    
   private func concurrentImageDownload() {
       let concurrentQueue = DispatchQueue(label: "com.concurrent.queue",qos: .default, attributes: .concurrent)
        imageURLs.forEach { [weak self] url in
            concurrentQueue.async {
                self?.semaphoreUseCase(url: url)
            }
        }
    }
}
