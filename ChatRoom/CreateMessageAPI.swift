//
//  CallWeatherAPI.swift
//  WeatherIOSAPP
//
//  Created by Mac on 10/31/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit
import Alamofire

protocol getMessageAPIDelegate {
    
    func getMessageText()->String
    func getMessageRoomId()->String
}


class CreateMessageAPI{
    
    var delegate : getMessageAPIDelegate?

    
    func callAPI(completed : @escaping DownloadComplete){
        
        
        let APIURLString = "\(CREATE_MESSAGES_URL)" // url
        
        let APIURL = URL(string: APIURLString)
        
        guard let text = delegate?.getMessageText(), let roomId = delegate?.getMessageRoomId(), let token_api = UserDefaults.standard.value(forKey: "token_api")
            else { return }
        
        
        let parameters: [String: Any] = [
            "room_id": roomId,
            "text": text,
            "api_token": token_api

        ]
 

        
        Alamofire.request(APIURL!, method: .post, parameters: parameters, encoding: JSONEncoding.default ).responseJSON { response in
            
   
            
            switch response.result {

                
                
            case .success:
   
                print("success")

                break
            case .failure(let error):
                
                print(error)
                
            }
            completed()
            
        }
    }
    
    
    
}
