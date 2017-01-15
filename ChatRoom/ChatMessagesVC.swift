//
//  ViewController.swift
//  IChat
//
//  Created by Mac on 12/23/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit
import SocketIO


class ChatMessagesVC: UIViewController,roomMessagesAPIDelegate , getMessageAPIDelegate, SocketData {
    
    // IBOutlet variables
    
    @IBOutlet var scrollView: UIScrollView! // scrollView
    @IBOutlet var mainView: MainView! // mainView
    @IBOutlet var actiivityIndicator: UIActivityIndicatorView!
    
    
    //  variables
    
    var chatRoomId : String? // room_id
    var messageText : String? // message Text
    
    var  socket : SocketIOClient! // Socket IO

   
    var roomMessageArray : [ChatMessage]? // messages array
    var roomMessagesAPI : RoomMessagesAPI? // Get Messages API
    var createMessageAPI : CreateMessageAPI? //Post Messages API
 
    var listScrollModel : ListScrollModel! // scrollView model to handle all scrolling functionalities

    

    
    // MARK: override UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        getPreviousMessagesAPI() // call get previous messages API
  
        listScrollModel = ListScrollModel.init(scrollView: self.scrollView) // list scroll model handle all scrolling functionalities
        socketConnection() // connect to socket

    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        
        //  load subviews
        
        loadSubViews()
 
    }
    
    
    // MARK: load subViews
    
    func loadSubViews(){
        
        mainView.loadViews(parent: self)
        
    }
    
    

    
// call get previous messages
    
    func getPreviousMessagesAPI(){
        
        roomMessagesAPI = RoomMessagesAPI()
        roomMessagesAPI?.delegate = self
        
        self.scrollView.isHidden = true // hide scoll view until finish loading all messages
        showActivityIndicator()
        
        
        roomMessagesAPI?.callAPI {
            
             self.loadMessages() // load messages
        }
    
    }
    
// MARK: socket connection
    
    
    func socketConnection(){
        
        socket = SocketIOClient.init(socketURL: URL.init(string: SOCKET_URL)!) // init socket
        
        socket.connect() // socket connect
        
        
 
        handleSocket() // handle listen operations
        
    }
    
// handle socket listen operations 
    
    
    func handleSocket(){
        
        
        self.socket.onAny {
            
            print("Got event: \($0.event), with items: \($0.items)") // for logging operations
        }
        
      // listen for socket at channel - chatRoomId
        
        self.socket.on("\(chatRoomId!)", callback: {data, ack in
      
            if let dictionary = data[0] as? Dictionary <String,AnyObject> {
                
                // get message and user_image

                if let message = dictionary["message"] as? String, let user_image = dictionary["user_image"] as? String {
                    
                    // post message
  
                    self.mainView.chatView?.postMessage(text: message, automatic: false, senderURL: user_image)
                    
                }
            }
    
        })
    
    }
    

    
// MARK :roomMessagesAPIDelegate methods
    

    func setChatMessagesArray(chatMessagesArray: [ChatMessage]) {
    
        self.roomMessageArray = chatMessagesArray
 
    }
    
    func getRoomId() -> String {
        
        return self.chatRoomId!
    }
    
    
// load previous message after finish API call
    
    func loadMessages(){
        
        for object in self.roomMessageArray!{
     
            self.mainView.chatView?.addMessagesAutomatically(text: object.text!, image: object.user_image!) // add message
            
        }
 
        // scrolling methods 
        
        self.listScrollModel.automaticUpdateScrollWithHiddenKeyboard()
        self.listScrollModel.scrollView.contentOffset = CGPoint(x: 0, y: self.listScrollModel.scrollView.contentSize.height - self.listScrollModel.scrollView.bounds.size.height)
        self.listScrollModel.automaticUpdateScrollWithHiddenKeyboard()
        
        
        Timer.scheduledTimer(withTimeInterval: TimeInterval(1.0), repeats: false) { timer in
        
            self.hideActivityIndicator() // hide activity indicator
            self.scrollView.isHidden = false  // show scroll view
            
        }
        
    }
    
  
// MARK :call post message API
    
    
    func postAPI(text: String){
        
        messageText = text
        
        createMessageAPI = CreateMessageAPI()
        createMessageAPI?.delegate = self
        
        createMessageAPI?.callAPI {
            
             self.emitSocket(text: text) // socket emit message
            
        }
     
    }
    
    // emit socket message
    
    func emitSocket(text : String){
        
        let messageData =
                      ["message": text, // text
                       "room_id": "\(chatRoomId!)", // channel - room id
                       "user_image" : UserDefaults.standard.value(forKey: "user_image") as! String] // user image
        
        self.socket.emit("Message", messageData) // socket emit message
        
        
    }
    
    
// MARK :getMessageAPIDelegate methods
   
    func getMessageText() -> String {
        
        return messageText!
    }
    
    func getMessageRoomId() -> String {
        
        return chatRoomId!
    }
    
 
    
// MARK:  activityIndicator methods
    
    func showActivityIndicator(){
        
        actiivityIndicator.isHidden = false
        actiivityIndicator.startAnimating()
        
    }
    
    func hideActivityIndicator(){
        
        actiivityIndicator.stopAnimating()
        actiivityIndicator.isHidden = true
        
    }
    
// MARK:  Button Actions 
    
    
    @IBAction func leaveGroup(_ sender: Any) {
        
        socket.disconnect() // disconnect socket
        self.navigationController?.popViewController(animated: true) // return back
        
    }

}

