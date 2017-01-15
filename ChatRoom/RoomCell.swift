//
//  ItemCell.swift
//  DreamLister
//
//  Created by Mac on 10/28/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit
import SDWebImage


class RoomCell: UITableViewCell {
    
     @IBOutlet var name: UILabel!
     @IBOutlet var date: UILabel!
     @IBOutlet var followers: UILabel!
     @IBOutlet var roomImageView: UIImageView!
    
     var id : String?
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
    }
    
    
    func configureCell(chatRoom: ChatRoom){

        if let id = chatRoom.id{
  
            self.id = id
        }
        
        if let image = chatRoom.imageURL{
            
 
            self.roomImageView.sd_setImage(with: URL.init(string: image), placeholderImage: UIImage.init(named: "placeholder"))
            
        }
        
        if let name = chatRoom.name{
            
            self.name.text = name
        }
        
        if let followers = chatRoom.followers{
            
            self.followers.text = followers
        }
        
        if let date = chatRoom.created{
            
            self.date.text = date
        }
        
        
    
    }
    
        
 
  
  

}
