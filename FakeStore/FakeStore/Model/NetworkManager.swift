//
//  NetworkManager.swift
//  FakeStore
//
//  Created by leewonseok on 2023/03/29.
//

import UIKit
import RxSwift

enum NetworkError: Error {
    case invalidURL
    case invalidResponse(code: Int)
    case requestFailed
    case invalidData
    case parseFailed
}

class NetworkManager {
    // MARK: - RxFunction
    static func fetchItemAllRx(urlString: String) -> Observable<[Item]> {
        return Observable.create { emitter in
            fetchItemAll(urlString: urlString) { result in
                switch result {
                case .success(let items):
                    emitter.onNext(items)
                    emitter.onCompleted()
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    static func fetchImageRx(urlString: String) -> Observable<UIImage> {
        return Observable.create { emitter in
            fetchImage(urlString: urlString) { result in
                switch result {
                case .success(let image):
                    emitter.onNext(image)
                    emitter.onCompleted()
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    // MARK: - NormalFunction
    static func fetchItemAll(urlString: String, completion: @escaping (Result<[Item], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse(code: 999)))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse(code: httpResponse.statusCode)))
                return
            }
            
            guard let data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            do {
                let itemList: [Item] = try JSONDecoder().decode([Item].self, from: data)
                completion(.success(itemList))
            } catch {
                completion(.failure(NetworkError.parseFailed))
            }
        }
        task.resume()
    }
    
    static func fetchImage(urlString: String,  completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse(code: 999)))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse(code: httpResponse.statusCode)))
                return
            }
            
            guard let data,
                  let image = UIImage(data: data)else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            completion(.success(image))
        }
        
        task.resume()
    }
}
