//
//  File.swift
//  IWeather
//
//  Created by Mac on 11/6/16.
//  Copyright © 2016 Mac. All rights reserved.
//


import Foundation
import UIKit

// screen size

let screenHeight = UIScreen.main.bounds.size.height
let screenWidth = UIScreen.main.bounds.size.width

// chat padding values

let roundedPadding : CGFloat = 10.0
let chatTextViewPadding : CGFloat = 10.0

let chatViewHeight : CGFloat = 70.0
let chatViewPadding : CGFloat = 25.0


// Scroll View padding

let scrollViewPaddingHeight : CGFloat = 10.0



let CREATE_USER_URL = "http://appsgeeks.de/user/create"
let CHAT_ROOMS_URL = "http://appsgeeks.de/api/chat/rooms/all?api_token="
let CHAT_MESSAGES_URL = "http://appsgeeks.de/api/chat/rooms/messages/"
let CREATE_MESSAGES_URL = "http://appsgeeks.de/api/chat/message/create"

// Scoket Constants


let SOCKET_URL = "https://damp-coast-53952.herokuapp.com/:3000"

//let CREATE_USER_URL = "http://192.168.0.100/KatiKidsWebSite/public/user/create"
//let CHAT_ROOMS_URL = "http://192.168.0.100/KatiKidsWebSite/public/api/chat/rooms/all?api_token="
//let CHAT_MESSAGES_URL = "http://192.168.0.100/KatiKidsWebSite/public/api/chat/rooms/messages/"
//let CREATE_MESSAGES_URL = "http://192.168.0.100/KatiKidsWebSite/public/api/chat/message/create/"


typealias DownloadComplete = () -> ()
