# ChatRoom

[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://swift.org/)
[![License](https://img.shields.io/cocoapods/l/ParallaxView.svg)](https://github.com/PGSSoft/ParallaxView/LICENSE.md)


'ChatRoom' provides that basics of Chat Rooms and Messaging functionalities Using Socket IO for asynchronous real-time chating and communication.

 
## Requirements

Swift 3.0

## Desc. 



‘ChatRoom' is a chat room based messenger available for iOS devices. With ChatRoom, everyone in the world can engage any chat room with the most popular topics, browse, join, create chat rooms and message other users.‘Chat Room’ uses the Socket IO for  real-time asynchronous communication between clients and server.

<p align="center">

 <img src="http://mawaeed.96.lt/uploads/chatRoom-chat-1.png" height="550" width="300">
 
</p>

## Installation  :

1. Install The Socket.IO-Client-Swift Pod
    
        1. pod 'Socket.IO-Client-Swift'

2. Connect to the Node JS Server 

```swift
import SocketIO

 let socket = SocketIOClient.init(socketURL: URL.init(string: SOCKET_URL)!) // init socket
        
socket.on("connect") {data, ack in
    print("socket connected")
}

 
socket.connect()
```


2. Socket Emit Post Message

```swift
import SocketIO

     let messageData =
                      ["message": text, // message to be send
                       "room_id": "\(chatRoomId!)", // channel - room id
                       "user_image" : image // user_image
        
     self.socket.emit("Message", messageData) // socket emit message

```


2. Socket on to listen for incoming events

```swift
import SocketIO

     self.socket.on("\(chatRoomId!)", callback: {data, ack in
      
            if let dictionary = data[0] as? Dictionary <String,AnyObject> {
                
                // get message and user_image

                if let message = dictionary["message"] as? String, let user_image = dictionary["user_image"] as? String {
                    
                    // post message
  
                    self.postMessage(text: message, senderURL: user_image)
                    
                }
            }
    
        })


```


 
## Steps :

    1. Run APP on Simulator or IOS Device and authorized yourself by login in your twitter account.
 
<p align="center">

 <img src="http://mawaeed.96.lt/uploads/chatRoom-twitter.png" height="550" width="300">
 
</p>
    
    
    2. Navigate the existing chatroom and enter your preferred chat room topic -  Technology / Cars / Immigration / …. etc. 
 

<p align="center">
 
   <img src="http://mawaeed.96.lt/uploads/chatRoom-groups.png" height="550" width="300">
 
</p>

     3. Start chating with others with nicely GUI and message design with  supporting all scrolling functionalities 
 
 <div align="center">
 
 <figure>
  <img src="http://mawaeed.96.lt/uploads/chatRoom-chat-1.png" height="550" width="300">
  <b>  </b>
  <img src="http://mawaeed.96.lt/uploads/chatRoom-chat-2.png" height="550" width="300">
</figure>
 
  </div>
  
 
## License

The project is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

 
## About

The project maintained by [Grand PH], [IOS and MAC Softwares]
See our other [open-source projects](https://itunes.apple.com/us/app/iweather-fc/id1178484560?mt=8), [download_our_app](https://itunes.apple.com/us/app/iweather-fc/id1178484560?mt=8) or [contact us ](https://twitter.com/MIhmouda).
