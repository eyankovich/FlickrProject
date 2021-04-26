//
//  RequestHandler.swift
//  FlickrProject
//
//  Created by Егор Янкович on 2/24/21.
//

import UIKit

class MakeRequest {
    
    enum CustomError: Error {
        case invalidResponce
        case badRequest
        case failed
        case noData
        case unableToDecode
    }
    
    func request<T: Decodable>(for request: RequestType<T>, completed: @escaping(Result<[T], Error>) -> ()) {
        let endpoint = request.urlComponents.url?.absoluteString
                
        guard let url = URL(string: endpoint!) else {
            completed(.failure(CustomError.badRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, responce, error in
            
            if error != nil {
                completed(.failure(CustomError.failed))
            }
            
            guard let data = data else {
                completed(.failure(CustomError.noData))
                return
            }
            
            guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else {
                completed(.failure(CustomError.invalidResponce))
                do {
                    let decoder = JSONDecoder()
                    let error = try decoder.decode(T.self, from: data)
                    completed(.success([error]))
                } catch {
                    completed(.failure(CustomError.unableToDecode))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movie = try decoder.decode(T.self, from: data)
                completed(.success([movie]))
            } catch {
                completed(.failure(CustomError.unableToDecode))
            }
        }
        task.resume()
    }
}

