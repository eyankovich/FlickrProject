//
//  RequestManager.swift
//  FlickrProject
//
//  Created by Егор Янкович on 2/24/21.
//

import Foundation

enum RequestType<T: Decodable> {
    case getResent(type: T.Type)
}

var vcClass = ViewController()

var pageC: String {
    var page1 = String()
    if let value = vcClass.userDefaults.value(forKey: "page") as? String {
        page1 = value
    } else {
        page1 = "1"
    }
   
    return page1
}

var perPageC: String {
    var perPage1 = String()
    if let value = vcClass.userDefaults.value(forKey: "perPage") as? String {
        perPage1 = value
    } else {
        perPage1 = "10"
    }
    
    return perPage1
}

extension RequestType: EndPoint {
    
    var dataType: Decodable.Type {
        switch self {
        case .getResent(let type):
            return type
        }
    }
    
    var path: String {
        switch self {
        case.getResent(_):
            return "/services/rest"
        }
    }
    
    var urlComponents: URLComponents {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = CodingValues.getvalue(for: "baseURL")
        urlComponents.path = path
        urlComponents.queryItems = [
        URLQueryItem(name: "method", value: "flickr.photos.getRecent"),
            URLQueryItem(name:  "per_page", value: perPageC),
            URLQueryItem(name:  "page", value: pageC),
            URLQueryItem(name:  "format", value: "json"),
            URLQueryItem(name:  "nojsoncallback", value: "1"),
            URLQueryItem(name: "api_key", value: CodingValues.getvalue(for: "api_key"))
        ]
        
        return urlComponents
    }
}
