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

protocol getChatRoomsAPIDelegate {
    
    func setChatRoomsArray(chatRoomArray : [ChatRoom]) // update array
    
}



class ChatRoomsAPI{
    
    var delegate : getChatRoomsAPIDelegate?
    var roomsArray : [ChatRoom]?

    func callAPI(completed : @escaping DownloadComplete){
        
        if let token_api = UserDefaults.standard.value(forKey: "token_api"){
        
            let APIURLString = "\(CHAT_ROOMS_URL)\(token_api)"
     
         Alamofire.request(APIURLString).responseJSON { response in
   
            switch response.result {
                
            case .success:
                
                
                if let resultDictionary = response.result.value as? Dictionary<String, AnyObject>{
                    
                    print(resultDictionary)

                    if let dataDictionary = resultDictionary["data"] as? Dictionary<String, AnyObject>{
                        
                        if let chatRooms = dataDictionary["chatRooms"] as? [Dictionary<String, AnyObject>]{
                            
                            self.roomsArray = [ChatRoom]()

                                for obj in chatRooms {
                                
                                    let room = ChatRoom()
                                    
                                    
                                    if let id = obj["id"] as? Int {
                                        
                                        room.id =  "\(id)"
  
                                    }
                                    
                                    if let name = obj["name"] as? String {
                                        
                                        room.name =  name
                                        
                                    }
                                    
                                    if let image = obj["image"] as? String {
                                        
                                        room.imageURL =  image
                                        
                                    }
                                    
                                    if let created_at = obj["created_at"] as? String {
                                        
                                        room.created =  created_at
                                        
                                    }
  
                                    
                                    
                                    self.roomsArray?.append(room)
 
                            }
                            
 
                            self.delegate?.setChatRoomsArray(chatRoomArray: self.roomsArray!) // update array
                            
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
