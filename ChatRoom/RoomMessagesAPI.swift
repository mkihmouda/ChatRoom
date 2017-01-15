//
//  CallWeatherAPI.swift
//  WeatherIOSAPP
//
//  Created by Mac on 10/31/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

protocol roomMessagesAPIDelegate {
    
    func setChatMessagesArray(chatMessagesArray : [ChatMessage])
    func getRoomId()->String
}



class RoomMessagesAPI{
    
    var delegate : roomMessagesAPIDelegate?
    var messagesArray : [ChatMessage]?

    
    
    func callAPI(completed : @escaping DownloadComplete){
        
        guard let roomId = delegate?.getRoomId(), let token_api = UserDefaults.standard.value(forKey: "token_api")
            else { return }
    
            let APIURLString = "\(CHAT_MESSAGES_URL)\(roomId)?api_token=\(token_api)"
            
        
            Alamofire.request(APIURLString).responseJSON { response in
                
                switch response.result {
                    
                case .success:
                    
                    if let resultDictionary = response.result.value as? Dictionary<String, AnyObject>{
                        
                        
                        if let dataDictionary = resultDictionary["data"] as? Dictionary<String, AnyObject>{
                            
                            if let chatMessages = dataDictionary["messages"] as? [Dictionary<String, AnyObject>]{
                                
                                
                                self.messagesArray = [ChatMessage]()
                                
                                for obj in chatMessages{
                                    
                                    let message = ChatMessage()
 
                                    
                                    if let text = obj["text"] as? String {
                                        
                                           message.text =  text
                                        
                                    }
                                    
                                    
                                    if let user_info = obj["user"] as?  Dictionary<String, AnyObject>{

                                        
                                        if let image = user_info["image"] as? String {
                                            
                                            message.user_image =  image
                                            
                                        }
 
                                    }
                                    
                                    self.messagesArray?.append(message)
                                    
                                }
                                
                                
                                self.delegate?.setChatMessagesArray(chatMessagesArray: self.messagesArray!)
                                
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
