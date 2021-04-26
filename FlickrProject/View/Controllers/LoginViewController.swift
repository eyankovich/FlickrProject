//
//  LoginViewController.swift
//  FlickrProject
//
//  Created by Егор Янкович on 3/17/21.
//

import UIKit
import OAuthSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginUILabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTestField: UITextField!
    
    let oauthParameter = OAuth()
    lazy var auth = oauthParameter.oauthswift
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginUILabel.accessibilityIdentifier = "loginTitle"
        passwordLabel.accessibilityIdentifier = "passwordTitle"
        loginTextField.accessibilityIdentifier = "userLogin"
        passwordTestField.accessibilityIdentifier = "userPassword"
        
    }
    
    func checkPassword(login: String, password: String)  {
        
        //   oauthParameter.getUploadStatus(auth, consumerKey: "7fc94f2cca0dc9714e6b410e90256ce9")
        //   oauthParameter.uploadPhoto(auth, consumerKey: "7fc94f2cca0dc9714e6b410e90256ce9")
        //  oauthParameter.testFlickr(auth, consumerKey: "7fc94f2cca0dc9714e6b410e90256ce9")
        
        let setupLogin = loginTextField.text
        let setupPassword = passwordTestField.text
        
        if setupLogin == login, setupPassword == password {
            
            if let tabbar = (storyboard?.instantiateViewController(withIdentifier: "tabbar") as? UITabBarController) {
                self.present(tabbar, animated: true, completion: nil)
            }
            
            loginUILabel.text = "Login"
            loginUILabel.textColor = .black
            loginUILabel.font = .boldSystemFont(ofSize: 15)
            passwordLabel.text = "Password"
            passwordLabel.textColor = .black
            passwordLabel.font = .boldSystemFont(ofSize: 15)
        } else {
            loginUILabel.text = "Incorrect password or login"
            loginUILabel.textColor = .red
            loginUILabel.font = .boldSystemFont(ofSize: 20)
            passwordLabel.text = "Try again"
            passwordLabel.textColor = .red
            passwordLabel.font = .boldSystemFont(ofSize: 20)
        }
    }
    
    @IBAction func logInButton(_ sender: Any) {
        checkPassword(login: CodingValues.getvalue(for: "login")!, password: CodingValues.getvalue(for: "password")!)
    }
}
