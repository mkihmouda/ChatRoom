//
//  ViewController.swift
//  ChatRoom
//
//  Created by Mac on 1/11/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import TwitterKit


class LoginVC: UIViewController, CreateUserAPIDelegate {

   
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
 
    var token : String?
    var session :TWTRSession? // tWitterSession
    var logInButton : TWTRLogInButton? // twitterLoginButton
    var createUserAPI : CreateUserAPI? // CreateUserAPI
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
  

             logInButton = TWTRLogInButton { (session, error) in
                if let unwrappedSession = session {
                    
                    // get session
                    
                     self.session = unwrappedSession
                    
                    // call Create User API
                    
                      self.callAPI()
 
                }
            }
        
        
        if  newUserLogin(){ // check if user already loggedin
            
            self.logInButton?.center = self.view.center
            self.view.addSubview(self.logInButton!)

        }else{
     
           postLogin() // post login process
            
        }
        
    }
    
// MARK: callAPI
    
    
    func callAPI(){
    
    createUserAPI = CreateUserAPI()
    createUserAPI?.delegate = self
        
        createUserAPI?.callAPI {
 
            self.postLogin() // post login process
        }
    
    
    }
    
// post login 
    
    func postLogin(){
    
      self.showActivityIndicator() // show activity indicator
      self.logInButton?.removeFromSuperview() // remove login button
        
      Timer.scheduledTimer(withTimeInterval: TimeInterval(2.0), repeats: false) { timer in
            
        self.hideActivityIndicator() // hide activity indicator
        
        self.performSegue(withIdentifier: "chat_room", sender: self) // next VC
            
        }
 
    
    }
    
// check new User Login
    
    
    func newUserLogin()->Bool{
        
        return  UserDefaults.standard.object(forKey: "token_api") == nil
    }
    
 
// MARK:  activityIndicator methods
 
    
    func showActivityIndicator(){
    
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
 
    }
    
    func hideActivityIndicator(){
        
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        
    }
 
// MARK:  CreateUser API Delegate 
    
    
    func getSession() -> TWTRSession {
        
        return self.session!
    }
    
 
    
}

