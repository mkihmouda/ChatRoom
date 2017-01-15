//
//  ChatRoomVC.swift
//  ChatRoom
//
//  Created by Mac on 1/11/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class ChatRoomVC: UIViewController,UITableViewDelegate,UITableViewDataSource, getChatRoomsAPIDelegate {

    @IBOutlet var tableView: UITableView!
    
    var chatRoomArray : [ChatRoom]?
    var chatRoomAPI : ChatRoomsAPI?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tableView.delegate = self
        self.tableView.dataSource = self
   
        chatRoomArray =  [ChatRoom]()
        callAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true // hide navigation bar

    }

    
// MARK: Table view delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = chatRoomArray?.count{
            
            return count

        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath) as! RoomCell
        
            let chatRoom = (chatRoomArray?[indexPath.row])! as ChatRoom
        
                cell.configureCell(chatRoom: chatRoom) // configure cell
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! RoomCell
   
        self.performSegue(withIdentifier: "chat_messages", sender: cell) // next VC
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
// MARK: call API
    
    
    func callAPI(){
        
        chatRoomAPI = ChatRoomsAPI()
        chatRoomAPI?.delegate = self
        
        chatRoomAPI?.callAPI {
         
            self.tableView.reloadData()
            
        }
        
        
    }


// update chatrooms array
    
    func setChatRoomsArray(chatRoomArray: [ChatRoom]) {
        
        self.chatRoomArray = chatRoomArray
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "chat_messages" {
 
            if let cell = sender as? RoomCell {
                
                if let roomId = cell.id{
  
                    let destination = segue.destination as! ChatMessagesVC
                    
                    destination.chatRoomId = roomId // set room id
                    
                }
    
            }
 
        }
    }
    

 
 
}
