//
//  MainView.swift
//  IChat
//
//  Created by Mac on 12/23/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    var chatView : ChatView?
    
    func loadViews(parent : ChatMessagesVC){
        
            chatView = Bundle.main.loadNibNamed("ChatView", owner: nil, options: nil)![0] as? ChatView
            chatView?.mainVC = parent
            chatView?.keyboardMethods()

        chatView?.frame.origin =  CGPoint(x: chatViewPadding,y : screenHeight - chatViewHeight)
        chatView?.frame.size = CGSize(width: screenWidth - chatViewPadding * 2 , height: chatViewHeight)
        
        self.addSubview(chatView!)
    }
    
}



// MARK: load instance from Bundle Extension

extension Bundle {
    class func instantiateNib<T>(owner: AnyObject? = nil) -> T {
        guard let instance = Bundle.main.loadNibNamed(String(describing: T.self), owner: owner)?.first as? T else {
            fatalError("Could not instantiate from nib: \(T.self)")
        }
        return instance
    }
}
