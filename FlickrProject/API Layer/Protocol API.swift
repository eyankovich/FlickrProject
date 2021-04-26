//
//  Protocal API.swift
//  FlickrProject
//
//  Created by Егор Янкович on 2/24/21.
//

import Foundation

protocol EndPoint {
    var urlComponents: URLComponents { get }
    var path: String { get }
    var dataType: Decodable.Type {get}
}


