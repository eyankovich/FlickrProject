//
//  EnviromentConfigsHandler.swift
//  FlickrProject
//
//  Created by Егор Янкович on 2/24/21.
//

import Foundation

struct CodingValues {
    
   static func getvalue(for key: String) -> String? {
        return Bundle.main.infoDictionary?[key] as? String
    }
}
