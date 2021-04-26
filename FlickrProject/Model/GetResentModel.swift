//
//  GetResentModel.swift
//  FlickrProject
//
//  Created by Егор Янкович on 2/24/21.
//

import Foundation


struct Photos: Codable {
    let photos: PageInfo?
    let stat: String?
}

struct PageInfo: Codable {
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let total: Int?
    let photo: [PhotosInfo]?
}

struct PhotosInfo: Codable {
    let id: String?
    let owner: String?
    let secret: String?
    let server: String?
    let farm: Int?
    let title: String?
    let ispublic: Int?
    let isfriend: Int?
    let isfamily: Int?
}
