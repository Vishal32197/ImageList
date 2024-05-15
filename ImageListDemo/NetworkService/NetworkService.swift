//
//  NetworkService.swift
//  ImageListDemo
//
//  Created by Bishal Ram on 15/05/24.
//

import Foundation

typealias completionHandler = (([ListData]?, NetworkError?) -> Void)

protocol NetworkServiceProtocol {
    func request(route: Route,
                 method: HTTPMethod,
                 completion: @escaping completionHandler)
}

class NetworkService: NetworkServiceProtocol {
    
    func request(route: Route,
                 method: HTTPMethod,
                 completion: @escaping completionHandler) {
        
        
        guard let url = URL(string: Environment.test.baseURL) else {
            return
        }
        
        var components = URLComponents(url: url.appendingPathComponent(route.rawValue), resolvingAgainstBaseURL: false)
        
        guard let finalURL = components?.url else {
            return
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error as? NetworkError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            if httpResponse.statusCode == 200 {
                guard let data = data else {
                    return
                }
                do {
                    let jsonData = try JSONDecoder().decode([ListData].self, from: data)
                    completion(jsonData, nil)
                }
                catch {
                    completion(nil, nil)
                }
            } else {
                completion(nil, nil)
                return
            }
            
        }.resume()
    }
}

