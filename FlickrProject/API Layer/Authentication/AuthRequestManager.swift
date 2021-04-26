//
//  AuthRequestManager.swift
//  FlickrProject
//
//  Created by Егор Янкович on 3/30/21.
//

import UIKit
import OAuthSwift

class OAuth {
    
    // Cсохранить токен в Keychain
    // Попробовать через NS URL Session
    
    //   let tempUserId: String?
    let userDefaults = UserDefaults()
    let oauthswift = OAuth1Swift(
        consumerKey:    "7fc94f2cca0dc9714e6b410e90256ce9",
        consumerSecret: "7cc13ebc17aadc56",
        requestTokenUrl: "https://www.flickr.com/services/oauth/request_token",
        authorizeUrl:    "https://www.flickr.com/services/oauth/authorize",
        accessTokenUrl:  "https://www.flickr.com/services/oauth/access_token"
    )
    
    var userID: String {
        var userid = String()
        if let value = userDefaults.value(forKey: "userID") as? String {
            userid = value
        } else {
            
        }
        return userid
    }
    
    var authToken: String {
        var token = String()
        if let value = userDefaults.value(forKey: "auth_token") as? String {
            token = value
        } else {
            
        }
        return token
    }
    
    
    func testFlickr (_ oauthswift: OAuth1Swift, consumerKey: String) {
        
        _ = oauthswift.authorize(
            withCallbackURL: "oauth-swift://oauth-callback/FlickrProject") { [self] result in
            switch result {
            case .success(let (credential, response, parameters)):
                userDefaults.setValue(parameters["user_nsid"] as! String, forKey: "userID")
                userDefaults.setValue(parameters["oauth_token"] as! String , forKey: "auth_token")
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    func uploadPhoto(_ oauthswift: OAuth1Swift, consumerKey: String) {
        
        let url1: String = "https://up.flickr.com/services/upload/"
        let image = UIImage(named: "JPEG_example_down")
        let data = image?.jpegData(compressionQuality: 0.9)
        let parameters1 =  Dictionary<String, AnyObject>()
        
        let a = oauthswift.client.postImage(url1, parameters: parameters1, image: data!) { result in
            switch result {
            case .success(let response):
                let jsonDict = try? response.jsonObject()
                print("SUCCESS: \(String(describing: jsonDict))")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getUploadStatus (_ oauthswift: OAuth1Swift, consumerKey: String) {
        let url :String = "https://api.flickr.com/services/rest/"
        let parameters :Dictionary = [
            "method"         : "flickr.people.getUploadStatus",
            "api_key"        : consumerKey ,
            "user_id"        : userID,
            "format"         : "json",
            "nojsoncallback" : "http://www.flickr.com/photos/upload/edit/?ids=1,2,3",
            "extras"         : "url_q,url_z"
        ]
        
        let b = oauthswift.client.get(url, parameters: parameters as OAuthSwift.Parameters) { result in
            switch result {
            case .success(let response):
                let jsonDict = try? response.jsonObject()
                print(jsonDict as Any)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getMyGalery(_ oauthswift: OAuth1Swift, consumerKey: String)  {
        
        let url :String = "https://api.flickr.com/services/rest/"
        let parameters :Dictionary = [
            "method":        "flickr.photos.recentlyUpdated",
            "api_key"        : consumerKey ,
            "min_date"       : "1617382862",
            "user_id"        : userID,
            "format"         : "json",
            "nojsoncallback" : "http://www.flickr.com/photos/upload/edit/?ids=1,2,3",
            "extras"         : "url_q,url_z"
            
        ]
        
        let _ = oauthswift.client.get(url, parameters: parameters as OAuthSwift.Parameters) { result in
            switch result {
            case .success(let response):
                let jsonDict = try? response.jsonObject()
                print(jsonDict as Any)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
