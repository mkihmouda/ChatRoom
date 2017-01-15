//
//  CallWeatherAPI.swift
//  WeatherIOSAPP
//
//  Created by Mac on 10/31/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit
import Alamofire
import TwitterKit

protocol CreateUserAPIDelegate {
    
    func getSession() -> TWTRSession

}

class CreateUserAPI{
    
    var delegate : CreateUserAPIDelegate?
   
 
 
    func callAPI(completed : @escaping DownloadComplete){
        
 
        let APIURLString = "\(CREATE_USER_URL)" // url
        let APIURL = URL(string: APIURLString)
        
        guard let session = delegate?.getSession() // get session
            else{return}

        let twitterClient = TWTRAPIClient(userID: session.userID)  // get twitter information - username and image

            twitterClient.loadUser(withID: session.userID) { (user, error) in
        
        if let user_image = user?.profileImageURL {
                
           self.storeUserImage(imageURL: user_image)
            
            let prameters : [String: Any] = [
                
                "email": "\(session.userName)@chat.com",
                "name": session.userName,
                "image" : user_image
            ]


    // post request

        Alamofire.request(APIURL!, method: .post, parameters: prameters, encoding: JSONEncoding.default ).responseJSON { response in
   
         switch response.result {

             case .success:

                if let resultDictionary = response.result.value as? Dictionary<String, AnyObject>{

                    if let dataDictionary = resultDictionary["data"] as? Dictionary<String, AnyObject>{

                        if let api_token = dataDictionary["api_token"] as? String{
 
                           self.storeUserToeknAPI(api_token : api_token)
                            
                        }
                    }
                }
                
                
                
            break
            case .failure(let error):
                
                print(error)
                
            }
        completed()
            }
            }
        }
    }
            
  
    
//     MARK:   Sotre User Default Values
    
    
    func storeUserToeknAPI(api_token : String){
       
            UserDefaults.standard.set(api_token, forKey: "token_api") // default rotation_mode - default is false
            UserDefaults.standard.synchronize()
        }
    
 
    func storeUserImage(imageURL: String){
        
        UserDefaults.standard.set(imageURL, forKey: "user_image") // default rotation_mode - default is false
        UserDefaults.standard.synchronize()
        
    }
    
    
}
